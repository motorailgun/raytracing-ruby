require './PPM.rb'

Height, Width = 256, 256

canvas = PPM.new(Height, Width)

Height.times{|h|
    Width.times{|w|
        r = w.to_f / (Width - 1)
        g = (Height - 1 - h).to_f / (Height - 1)
        b = 0.25
        
        canvas[h][w].set(r, g, b)
    }
}

puts canvas