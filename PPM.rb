require './RGB.rb'

class PPM
    attr_accessor :canvas
    def initialize(width = 640, height = 480, level = 256, default = 0)
        @canvas = Array.new(height){ Array.new(width){ RGB.new(default) } }
        @width, @height = width, height
        @level = level
    end

    def to_s
        "P3\n#{@width} #{@height}\n#{@level}".concat(
            @canvas.reduce(""){|str, array|
                str + array.reduce("\n"){|str, rgb| str + " " + rgb.to_s }
            }
        )
    end

    def [](idx)
        @canvas[idx]
    end
end