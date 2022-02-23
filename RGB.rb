require './Triplet.rb'

class RGB < Triplet
    [[:r, :x], [:g, :y], [:b, :z]].each{|ar|
        eval("alias #{ar[0]} #{ar[1]}")
        eval("alias #{ar[0]}= #{ar[1]}=")
    }

    def initialize(x = 0.0, y = nil, z = nil, color_level = 256)
        @color_level = color_level
        super
    end

    undef_method(:join)
    def to_s
        [@x, @y, @z].map{ ((@color_level - 0.001) * _1).to_i }.reduce{|result, pt| result.to_s + ' ' + pt.to_s }
    end
end