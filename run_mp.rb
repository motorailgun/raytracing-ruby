require './preperation'

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
