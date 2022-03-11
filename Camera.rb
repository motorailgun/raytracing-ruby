require_relative './Point3D'

class Camera
    attr_reader :viewport_height, :viewport_width, :focal_length, :origin

    def initialize(aspect_ratio: 16.0 / 9.0,
                  focal_length: 1.0,
                  origin: p3d(0.0, 0.0, 0.0),
                  v_fov: 90
                )
        
        raise ArgumentError.new("Origin must be kind of Point3D") unless origin.kind_of?(Point3D)
        
        tant = Math.tan(v_fov * Math::PI / 180.0 / 2)
        @viewport_height = 2.0 * tant
        @viewport_width = aspect_ratio * @viewport_height
        
        @aspect_ratio, @focal_length = aspect_ratio, focal_length
        @origin = origin

        @horizontal = p3d(@viewport_width, 0.0, 0.0)
        @vertical = p3d(0.0, @viewport_height, 0.0)
        @lower_left_corner = @origin - @horizontal / 2.0 - @vertical / 2.0 - p3d(0.0, 0.0, @focal_length)
    end

    def get_ray(u, v)
        ray(@origin, @lower_left_corner + u * @horizontal + v * @vertical - @origin)
    end
end
