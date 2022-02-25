require './Hittable.rb'

class Sphere < Hittable
    attr_accessor :center, :radius

    def initialize(center, radius)
        raise ArgumentError.new("Sphere's center must be point") unless center.kind_of?(Point3D)
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
            t = (-b - sqrt_d) / a
            if t < t_min || t_max < t then
                t = (-b + sqrt_d) / a
                return false if t < t_min || t_max < t
            end
        end

        hit_point = ray.at(t)
        outward_normal = (point - center) / radius
        face_normal = face_normal(ray, outward_normal) # face_normal is the same as outward_normal if the ray comes from outside of the sphere
        is_front_face = (face_normal == outward_normal) # is_front_face is true if ^^
        # outward_normal always points outside of the sphere.
        # thus, if the ray is inside the sphere, dot of ray.direction and outward_normal is > 0.
        # similarly, if the ray is outside the sphere, dot if ray.direction and outward_normal is < 0.
        # (if on the surface of sphere, it depends on where the ray points)

        return true, t, hit_point, face_normal, is_front_face
    end

    private
    def face_normal(ray, outward_normal)
        is_front_face = ray.direction.dot(outward_normal) < 0
        is_front_face ? outward_normal : -outward_normal
    end
end