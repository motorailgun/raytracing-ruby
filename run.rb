require './rtweekend'

# image properties
aspect_ratio = 16.0 / 9.0
image_width = 400
image_height = Integer(image_width / aspect_ratio)

# world
world = HittableList.new
world.add(Sphere.new(p3d(0.0, 0.0, -1.0), 0.5))
world.add(Sphere.new(p3d(0.0, -100.5, -1.0), 100.0))

# camera properties
camera = Camera.new(:height => 2.0, :focal_length => 1.0)
samples = 100

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
            color += ray_color(ray, world)
        }
        canvas[h][w] = clamp_color(color, samples)
    }
}

puts canvas