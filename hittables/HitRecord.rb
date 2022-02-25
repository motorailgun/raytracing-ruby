class HitRecord
    attr_accessor :hit_point, :normal, :t, :front_face?

    def initialize(hit_point = nil, normal = nil, t = nil, front_face? = nil)
        @hit_point, @normal, @t, @front_face? = hit_point, normal, t, front_face?
    end
end