require './Triplet.rb'

class Vector3D < Triplet
    def initialize(x = 0.0, y = nil, z = nil)
        super
    end

    def ==(other)
        if other.kind_of?(self.class)
            @x == other.x && @y == other.y && @z == other.z
        else
            false
        end
    end

    def Vector3D.rand_vec(lower_limit = 0.0, upper_limit = 1.0)
        lower_limit, upper_limit = Float(lower_limit), Float(upper_limit)
        range = lower_limit..upper_limit
        Vector3D.new(rand(range), rand(range), rand(range))
    end
end

def v3d(x = 0.0, y = nil, z = nil)
    Vector3D.new(x.to_f, y ? y.to_f : x.to_f, z ? z.to_f : x.to_f)
end