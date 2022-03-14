require './rtweekend'

# image properties
aspect_ratio = 16.0 / 9.0
image_width = 400
image_height = Integer(image_width / aspect_ratio)

# world
world = random_scene

# camera properties
look_from = p3d(13.0, 2.0, 3.0)
look_at = p3d(0.0, 0.0, 0.0)
focus_distance = 10.0
aperture = 0.2
camera = Camera.new(:v_fov => 20, :aspect_ratio => aspect_ratio,
                    :look_from => look_from,
                    :look_at => look_at,
                    :vec_view_up => v3d(0.0, 1.0, 0.0),
                    :aperture => aperture,
                    :focus_distance => focus_distance
                )
samples = 50

max_depth = 25


pids = []
readers = []

image_height.times{|h|
    reader, writer = IO.pipe
    readers.push(reader)

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
                color += ray_color(ray, world, max_depth)
            }

            res.push(clamp_color(color, samples))
        }

        writer.puts(res.map{_1.to_s}.join(" "))
        $stderr.puts "line #{h + 1} out of #{image_height}: Done"
        $stderr.flush
        writer.close
    end)
}

pids.each{Process.waitpid(_1)}

puts "P3"
puts "#{image_width} #{image_height}"
puts "#{256}"

readers.each{
    puts _1.gets
    _1.close
}
