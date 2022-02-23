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
        @x /= num
        @y /= num
        @z /= num
    end

    [:+, :-, '*', '/'].each{|sym|
        define_method(sym){|operand|
            if [:x, :y, :z].all?{|attribute| operand.respond_to?(attribute) } then
                self.class.new(
                    @x.send(sym, operand.x),
                    @y.send(sym, operand.y),
                    @z.send(sym, operand.z) 
                )
            else
                self.class.new(
                    @x.send(sym, operand),
                    @y.send(sym, operand),
                    @z.send(sym, operand) 
                )
            end
        }
    }

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

def trpl(x = 0, y = 0, z = 0)
    Triplet.new(x, y, z)
end