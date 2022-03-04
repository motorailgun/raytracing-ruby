require_relative './Material'

class Dielectric < Material
    attr_reader :relative_reflective_indice

    private
    def reflact(input_vector, normal, relative_reflective_index)
        
    end
end