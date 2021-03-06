require_relative '../rtweekend'

class Lambertian < Material
    def initialize(attenuation = rgb())
        @attenuation = attenuation
    end

    def reflect(ray, hit_record)
        scatter_direction = hit_record.normal + rand_unit_vector
        scatter_direction = hit_record.normal if scatter_direction.near_zero?
        ray(hit_record.hit_point, scatter_direction)
    end
end