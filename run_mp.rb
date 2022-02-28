require './rtweekend'
require 'pp'

def ray_color(ray, world)
    if hit_record = world.hit(ray, 0.0, Infinity) then
        return  0.5 * (rgb(hit_record.normal) + rgb(1.0, 1.0, 1.0));
    end
    unit_direction = ray.direction.unit_vector
    seppen = 0.5 * (unit_direction.y + 1.0)
    (1.0 - seppen) * rgb(1.0, 1.0, 1.0) + seppen * rgb(0.5, 0.7, 1.0)
end

def clamp_color(color, samples)
    color * (1.0 / samples)
    # ^^ must be faster than deviding three(r, g, b) ?
    # this calculation is done for every pixel, so faster must be better
end

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
samples = 50

canvas = PPM.new(image_width, image_height)

pids = []

image_height.times{|h|
    reader, writer = IO.pipe
    pids.push(fork do
        res = []
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

            res.push(clamp_color(color, samples))
        }

        Marshal.dump(res, writer)
        $stderr.puts "line #{h + 1} out of #{image_height}: Done"
        $stderr.flush
        writer.close
    end)
    canvas.canvas[h] = reader
}

pids.each{Process.waitpid(_1)}
canvas.canvas = canvas.canvas.map{
    res = Marshal.load(_1)
    _1.close
    res
}
puts canvas