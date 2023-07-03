require './hittables/HitRecord'
require './hittables/HittableList'
require './hittables/Sphere'

require './materials/Material'
require './materials/Lambertian'
require './materials/Metal'
require './materials/Dielectric'

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

def random_scene
    world = HittableList.new

    material_ground = Lambertian.new(rgb(0.5, 0.5, 0.5))
    world.add(Sphere.new(p3d(0.0, -1000.0, 0), 1000.0, material_ground))

    for x in -11..11 do
        for z in -11..11 do
            material_value = rand
            sp_center = p3d(x + rand * 0.9, 0.2, z + rand * 0.9)

            if (sp_center - p3d(4.0, 0.2, 0.0)).length > 0.9 then
                if material_value < 0.8 then
                    # diffuse
                    color = RGB::rand(0.0, 1.0) * RGB::rand(0.0, 1.0)
                    sp_material = Lambertian.new(color)
                    world.add(Sphere.new(sp_center, 0.2, sp_material))
                elsif material_value < 0.95 then
                    # metal
                    color = RGB::rand(0.5, 1.0)
                    fuzz = rand(0.0..0.5)
                    sp_material = Metal.new(color, fuzz)
                    world.add(Sphere.new(sp_center, 0.2, sp_material))
                else
                    # glass
                    sp_material = Dielectric.new(1.5)
                    world.add(Sphere.new(sp_center, 0.2, sp_material))
                end
            end
        end
    end
    
    world.add(Sphere.new(p3d(0.0, 1.0, 0.0), 0.6, Dielectric.new(1.5)))
    world.add(Sphere.new(p3d(-4.0, 1.0, 0.0), 0.6, Lambertian.new(rgb(0.5, 0.2, 0.1))))
    world.add(Sphere.new(p3d(4.0, 1.0, 0.0), 0.8, Metal.new(rgb(0.6, 0.6, 0.7), 0.0)))

    world
end
