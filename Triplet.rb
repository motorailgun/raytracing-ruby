class Triplet
    attr_accessor :x, :y, :z

    # methods required for calcuration
    def coerce(numeric)
        [self, numeric]
    end

    def -@
        self.class.new(-@x, -@y, -@z)
    end

    def **(num)
        @x ** num + @y ** num + @z ** num
    end

    def length
        Math.sqrt(self ** 2)
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
        @x /= num.to_f
        @y /= num.to_f
        @z /= num.to_f
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

    [:/, :%].each{|sym|
        define_method(sym){|operand|
            self.class.new(
                @x.send(sym, operand.to_f),
                @y.send(sym, operand.to_f),
                @z.send(sym, operand.to_f) 
            )
        }
    }

    def *(operand)
        if [:x, :y, :z].all?{|attribute| operand.respond_to?(attribute) } then
            self.class.new(
                @x.send(:*, operand.x),
                @y.send(:*, operand.y),
                @z.send(:*, operand.z) 
            )
        else
            self.class.new(
                @x.send(:*, operand),
                @y.send(:*, operand),
                @z.send(:*, operand) 
            )
        end
    end

    def self.dot(u, v)
        u.x * v.x + u.y * v.y + u.z * u.z
    end

    def dot(v)
        @x * v.x + @y * v.y + @z * v.z
    end

    def self.cross(u, v)
        self.class.new(u.y * v.z - u.z * v.y,
                       u.z * v.x - u.x * v.z,
                       u.x * v.y - u.y * v.x)
    end
    
    def cross(v)
        self.class.new(@y * v.z - @z * v.y,
                       @z * v.x - @x * v.z,
                       @x * v.y - @y * v.x)
    end

    def unit_vector
        self / self.length
    end

    # normal (and utilities) methods below
    def initialize(x = 0, y = nil, z = nil)
        if x.kind_of?(Triplet) then
            x = x.to_trpl
            @x, @y, @z = [:x, :y, :z].map{ x.send(_1) }
            return self
        end

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

    def to_trpl
        self.clone
    end

    def self.rand(lower_limit = 0.0, upper_limit = 1.0)
        lower_limit, upper_limit = Float(lower_limit), Float(upper_limit)
        range = lower_limit..upper_limit
        self.class.new(rand(range), rand(range), rand(range))
    end
end

def trpl(x = 0, y = 0, z = 0)
    Triplet.new(x, y, z)
end