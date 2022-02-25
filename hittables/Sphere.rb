require './Hittable.rb'

class Sphere < Hittable
    attr_accessor :center, :radius

    def initialize(center, radius)
        raise ArgumentError unless center.kind_of?(Point3D)
        @center = center
        @radius = Float(radius)
    end

    def hit?(ray, t_max, t_min)
        center_to_origin = ray.origin - @center
        a = ray.direction ** 2
        b = center_to_origin.dot(ray.direction)
        c = center_to_origin**2 - @radius ** 2
        discriminat = b**2 - a * c
        sqrt_d = Math.sqrt(discriminat)
    
        if discriminat < 0 then
            false
        else
            t = (-b - Math.sqrt(determinant)) / a
            if t < t_min || t_max < t then
                t = (-b + Math.sqrt(determinant)) / a
                return false if t < t_min || t_max < t
            end

            return true, t, point = ray.at(t), (point - center).unit_vector
        end
    end
end