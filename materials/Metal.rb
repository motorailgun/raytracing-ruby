require_relative '../rtweekend'

class Lambertian < Material
    def initialize(attenuation = rgb(0.99))
        @attenuation = attenuation
    end

    def reflect(ray, hit_record)
        reflect_direction = metal_reflect(ray.direction.unit_vector, hit_record.normal)
        reflected_ray = ray(hit_record.hit_point, scatter_direction)
        return reflected_ray.direction.dot(hit_record.normal) > 0 && reflected_ray
    end

    private
    def metal_reflect(vector, normal)
        vector - (vector.dot(normal) * normal)
    end
end