require_relative './Material'
require_relative '../rtweekend'

class Dielectric < Material
    attr_reader :index_of_refraction, :attenuation

    def initialize(index_of_refraction)
        @index_of_refraction = index_of_refraction
        @attenuation = rgb(1.0, 1.0, 1.0)
    end

    def reflect(ray, hit_record)
        refraction_ratio = hit_record.front_face ? (1.0 / @index_of_refraction) : @index_of_refraction;

        unit_direction = ray.direction.unit_vector
        refracted = refract(unit_direction, hit_record.normal, refraction_ratio)
        
        ray(hit_record.hit_point, refracted)
    end

    private
    def refract(input_vector, normal, relative_reflective_index)
        cost = [(-input_vector).dot(normal), 1.0].min
        r_out_perpendicular = relative_reflective_index * (input_vector + cost * normal)
        r_out_parallel = -Math.sqrt((1.0 - r_out_perpendicular ** 2).abs) * normal
        r_out_parallel + r_out_perpendicular
    end

end