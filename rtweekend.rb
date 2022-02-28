require './hittables/HitRecord'
require './hittables/HittableList'
require './hittables/Sphere'

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

def ray_color(ray, world)
    if hit_record = world.hit(ray, 0.0, Infinity) then
        return  0.5 * (rgb(hit_record.normal) + rgb(1.0, 1.0, 1.0));
    end
    unit_direction = ray.direction.unit_vector
    seppen = 0.5 * (unit_direction.y + 1.0)
    (1.0 - seppen) * rgb(1.0, 1.0, 1.0) + seppen * rgb(0.5, 0.7, 1.0)
end

def clamp_color(color, samples)
    color * (1.0 / samples)
    # ^^ must be faster than deviding three(r, g, b) ?
    # this calculation is done for every pixel, so faster must be better
end
