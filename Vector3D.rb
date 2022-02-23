require './Triplet.rb'

class Vector3D < Triplet
    def initialize(x = 0.0, y = nil, z = nil)
        super
    end

    def unit_vector
        self / self.length
    end
end

def v3d(x = 0.0, y = nil, z = nil)
    Vector3D.new(x.to_f, y ? y.to_f : x.to_f, z ? z.to_f : x.to_f)
end