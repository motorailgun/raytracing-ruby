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
