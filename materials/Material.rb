class Material
    attr_reader :attenuation

    def initialize(attenuation = rgb())
        @attenuation = attenuation
    end
end