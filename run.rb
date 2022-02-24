require './PPM.rb'
require './Vector3D.rb'
require './Point3D.rb'
require './RGB.rb'
require './Ray.rb'

def hit_sphere(center, radius, ray)
    origin_to_center = center - ray.origin
    a = ray.direction.dot(ray.direction)
    b = 2.0 * origin_to_center.dot(ray.direction)
    c = origin_to_center.dot(origin_to_center) - radius ** 2
    (b**2 - 4 * a * c) > 0
end

def ray_color(ray)
    if hit_sphere(p3d(0.0, 0.0, -1.0), 0.5, ray) then
        return rgb(1.0, 0.0, 0.0)
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