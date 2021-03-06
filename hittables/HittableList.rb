require_relative './HitRecord.rb'

class HittableList
    attr_accessor :objects

    def initialize
        @objects = []
    end

    def add(obj)
        raise ArgumentError.new("#{obj.class} is not a hittable object") unless obj.kind_of?(Hittable)
        @objects.push(obj)
    end

    def hit(ray, t_min, t_max)
        hit_record = false
        closest_so_far = t_max

        @objects.each{|obj|
            if hitted = obj.hit(ray, t_min, closest_so_far) then
                closest_so_far = hitted.t
                hit_record = hitted
            end
        }

        hit_record
    end
end