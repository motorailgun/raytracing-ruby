class HitRecord
    attr_accessor :hit_point, :normal, :t, :front_face?

    def initialize(hit_point, normal, t, front_face?)
        @hit_point, @normal, @t, @front_face? = hit_point, normal, t, front_face?
    end
end