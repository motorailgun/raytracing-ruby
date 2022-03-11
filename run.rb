require './rtweekend'

# image properties
aspect_ratio = 16.0 / 9.0
image_width = 400
image_height = Integer(image_width / aspect_ratio)

# world
world = HittableList.new
radius = Math.cos(Math::PI / 4.0)

material_left = Lambertian.new(rgb(0.0, 0.0, 1.0))
material_right = Lambertian.new(rgb(1.0, 0.0, 0.0))

world.add(Sphere.new(p3d(-radius, 0.0, -1.0), radius, material_left))
world.add(Sphere.new(p3d(radius, 0.0, -1.0), radius, material_right))

# camera properties
camera = Camera.new(:v_fov => 90, :aspect_ratio => aspect_ratio)
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