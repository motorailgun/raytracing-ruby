require './hittables/HitRecord'
require './hittables/HittableList'
require './hittables/Sphere'

require './materials/Material'
require './materials/Lambertian'
require './materials/Metal'

require './PPM'
require './Ray'
require './RGB'
require './Camera'

Infinity = Float::INFINITY

def randvec_in_unit_sphere
    loop{
        v = Vector3D::rand
        next if v ** 2 >= 1
        return v
    }
end

def rand_unit_vector
    randvec_in_unit_sphere.unit_vector
end

def ray_color(ray, world, depth)
    return rgb(0.0, 0.0, 0.0) if depth <= 0

    if hit_record = world.hit(ray, 0.001, Infinity) then
        reflected_ray = hit_record.material.reflect(ray, hit_record)
        attenuation = hit_record.material.attenuation
        if reflected_ray then
            return  attenuation * ray_color(reflected_ray, world, depth - 1)
        end
        return rgb(0.0, 0.0, 0.0)
    end

    unit_direction = ray.direction.unit_vector
    seppen = 0.5 * (unit_direction.y + 1.0)
    (1.0 - seppen) * rgb(1.0, 1.0, 1.0) + seppen * rgb(0.5, 0.7, 1.0)
end

def clamp_color(color, samples)
    (color * (1.0 / samples)).sqrt
    # ^^ must be faster than deviding three(r, g, b) ?
    # this calculation is done for every pixel, so faster must be better
end
