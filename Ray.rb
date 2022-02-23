require './Point3D.rb'
require './Vector3D.rb'

class Ray
    attr_accessor :origin, :direction

    def initialize(origin, direction)
        @origin = origin
        @direction = direction
    end

    def at(t)
        @origin + direction * t
    end
end

def ray(origin, direction)
    Ray.new(origin, direction)
end