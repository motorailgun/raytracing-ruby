require './Triplet.rb'

class Point3D < Triplet
    def initialize(x = 0, y = nil, z = nil)
        super
    end
end

def p3d(x = 0.0, y = nil, z = nil)
    Point3D.new(x.to_f, y ? y.to_f : x.to_f, z ? z.to_f : x.to_f)
end