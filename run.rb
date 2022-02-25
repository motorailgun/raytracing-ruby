require './PPM.rb'
require './Vector3D.rb'
require './Point3D.rb'
require './RGB.rb'
require './Ray.rb'

def hit_sphere(center, radius, ray)
    center_to_origin = ray.origin - center
    a = ray.direction ** 2
    b = center_to_origin.dot(ray.direction)
    c = center_to_origin**2 - radius ** 2
    determinant = b**2 - a * c

    if determinant < 0 then
        false
    else
        (-b - Math.sqrt(determinant)) / a
    end
end

def ray_color(ray)
    if t = hit_sphere(p3d(0.0, 0.0, -1.0), 0.5, ray) then
        vec = (ray.at(t) - p3d(0.0, 0.0, -1.0)).unit_vector
        return rgb(vec.x + 1, vec.y + 1, vec.z + 1) * 0.5
    end
    unit_direction = ray.direction.unit_vector
    seppen = 0.5 * (unit_direction.y + 1.0)
    (1.0 - seppen) * rgb(1.0, 1.0, 1.0) + seppen * rgb(0.5, 0.7, 1.0)
end

# image properties
aspect_ratio = 16.0 / 9.0
image_width = 400
image_height = Integer(image_width / aspect_ratio)

# camera properties
viewport_height = 2.0
viewport_width = Float(viewport_height * aspect_ratio)
focal_length = 1.0

origin = Point3D.new(0.0, 0.0, 0.0)
horizontal = Vector3D.new(viewport_width, 0.0, 0.0)
vertical = Vector3D.new(0.0, viewport_height, 0.0)
lower_left_corner = origin - horizontal/2.0 - vertical/2.0 - v3d(0.0, 0.0, focal_length)

canvas = PPM.new(image_width, image_height)

image_height.times{|h|
    image_width.times{|w|
        x = w.to_f / (image_width - 1)
        y = (image_height - h).to_f / (image_height - 1)
        r = Ray.new(origin, lower_left_corner + x * horizontal + y * vertical - origin)
        color = ray_color(r)

        canvas[h][w] = color
    }
}

puts canvas