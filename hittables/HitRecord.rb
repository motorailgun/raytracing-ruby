class HitRecord
    attr_accessor :hit_point, :normal, :t, :front_face, :material

    def initialize(hit_point = nil, normal = nil, t = nil, front_face = nil, material = nil)
        @hit_point, @normal, @t, @front_face, @material = hit_point, normal, t, front_face, material
    end
end