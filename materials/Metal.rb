require_relative '../rtweekend'

class Metal < Material
    def initialize(attenuation = rgb(0.99), roughness = 0.0)
        @attenuation = attenuation
        @roughness = roughness > 1.0 ? 1.0 : roughness
    end

    def reflect(ray, hit_record)
        reflect_direction = metal_reflect(ray.direction.unit_vector, hit_record.normal)
        reflected_ray = ray(hit_record.hit_point, reflect_direction + randvec_in_unit_sphere * @roughness)
        return reflected_ray.direction.dot(hit_record.normal) > 0 && reflected_ray
    end

    private
    def metal_reflect(vector, normal)
        vector - 2 * (vector.dot(normal) * normal)
    end
end