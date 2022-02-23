class Triplet
    attr_accessor :x, :y, :z

    # methods required for calcuration
    def -@
        self.class.new(-@x, -@y, -@z)
    end

    def **(num)
        @x ** num + @y ** num + @z ** num
    end

    def length
        Math.sqrt(** 2)
    end
    
    def plus_equal(ins)
        @x += ins.x
        @y += ins.y
        @z += ins.z
    end

    def minus_equal(ins)
        @x -= ins.x
        @y -= ins.y
        @z -= ins.z
    end

    def mtply_equal(num)
        @x *= num
        @y *= num
        @z *= num
    end

    def div_equal(num)
        @x /= num
        @y /= num
        @z /= num
    end

    [:+, :-].each{|sym|
        define_method(sym){|operand|
            self.class.new(
                @x.send(sym, operand.x),
                @y.send(sym, operand.y),
                @z.send(sym, operand.z) 
            )
        }
    }

    ['*', '/'].each{|sym|
        define_method(sym){|operand|
            self.class.new(
                @x.send(sym, operand),
                @y.send(sym, operand),
                @z.send(sym, operand) 
            )
        }
    }

    # normal (and utilities) methods below
    def initialize(x = 0, y = nil, z = nil)
        @x, @y, @z = x, (y || x), (z || x)
    end

    def [](idx)
        [@x, @y, @z][idx]
    end

    def set(x, y, z)
        @x, @y, @z = x, y, z
    end

    def join(str = "")
        [@x, @y, @z].reduce{|result, pt| result.to_s + str + pt.to_s }
    end

    def to_s
        join(" ")
    end
end