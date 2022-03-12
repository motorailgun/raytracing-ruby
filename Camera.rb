require_relative './Point3D'

class Camera
    attr_reader :viewport_height, :viewport_width, :focal_length, :origin

    def initialize(aspect_ratio: 16.0 / 9.0,
                  focal_length: 1.0,
                  origin: p3d(0.0, 0.0, 0.0),
                  v_fov: 90,
                  look_from: ,
                  look_at: ,
                  vec_view_up: 
                )
        
        raise ArgumentError.new("Origin must be kind of Point3D") unless origin.kind_of?(Point3D)
        
        tant = Math.tan(v_fov * Math::PI / 180.0 / 2)
        @viewport_height = 2.0 * tant
        @viewport_width = aspect_ratio * @viewport_height
        
        @aspect_ratio, @focal_length = aspect_ratio, focal_length
        @origin = origin

        w = (look_from - look_at).unit_vector
        u = vec_view_up.cross(w).unit_vector
        v = w.cross(u)

        @origin = look_from
        @horizontal = @viewport_width * u
        @vertical = @viewport_height * v
        @lower_left_corner = @origin - @horizontal / 2 - @vertical / 2 - w
    end

    def get_ray(u, v)
        ray(@origin, @lower_left_corner + u * @horizontal + v * @vertical - @origin)
    end
end
