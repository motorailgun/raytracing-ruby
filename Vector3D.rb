require './Triplet.rb'

class Vector3D < Triplet
    def initialize(x = 0.0, y = nil, z = nil)
        super
    end
end

def v3d(x = 0.0, y = 0.0, z = 0.0)
    Vector3D.new(x.to_f, y.to_f, z.to_f)
end