class Triplet
    attr_accessor :x, :y, :z

    def initialize(init_value: 0)
        @x, @y, @z = init_value, init_value, init_value
    end

    def [](idx)
        [@x, @y, @z][idx]
    end
end