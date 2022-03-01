require_relative '../rtweekend'

class Metal < Material
    def initialize(attenuation = rgb(0.99))
        @attenuation = attenuation
    end

    def reflect(ray, hit_record)
        reflect_direction = metal_reflect(ray.direction.unit_vector, hit_record.normal)
        reflected_ray = ray(hit_record.hit_point, reflect_direction)
        return reflected_ray.direction.dot(hit_record.normal) > 0 && reflected_ray
    end

    private
    def metal_reflect(vector, normal)
        vector - 2 * (vector.dot(normal) * normal)
    end
end