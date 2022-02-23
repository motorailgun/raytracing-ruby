require './Triplet.rb'

class Point3D < Triplet
    def initialize(x = 0, y = nil, z = nil)
        super
    end
end

def p3d(x = 0.0, y = 0.0, z = 0.0)
    Point3D.new(x, y, z)
end