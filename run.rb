require './rtweekend'

# image properties
aspect_ratio = 16.0 / 9.0
image_width = 400
image_height = Integer(image_width / aspect_ratio)

# world
world = HittableList.new

material_ground = Lambertian.new(rgb(0.8, 0.8, 0.0))
material_center = Lambertian.new(rgb(0.7, 0.3, 0.3))
material_left = Metal.new(rgb(0.8, 0.8, 0.8))
material_right = Metal.new(rgb(0.8, 0.6, 0.2))

world.add(Sphere.new(p3d(0.0, -100.5, -1.0), 100.0, material_ground))
world.add(Sphere.new(p3d(0.0, 0.0, -1.0), 0.5, material_center))
world.add(Sphere.new(p3d(-1.0, 0.0, -1.0), 0.5, material_left))
world.add(Sphere.new(p3d(1.0, 0.0, -1.0), 0.5, material_right))

# camera properties
camera = Camera.new(:height => 2.0, :focal_length => 1.0)
samples = 50

max_depth = 25


canvas = PPM.new(image_width, image_height)

image_height.times{|h|
    $stderr.puts "line #{h + 1} out of #{image_height}: processing..."
    $stderr.flush

    image_width.times{|w|
        color = rgb()
        samples.times{
            x = (w.to_f + rand) / (image_width - 1)
            y = (image_height - h + rand).to_f / (image_height - 1)
            ray = camera.get_ray(x, y)
            color += ray_color(ray, world, max_depth)
        }
        canvas[h][w] = clamp_color(color, samples)
    }
}

puts canvas