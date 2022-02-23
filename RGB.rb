require './Triplet.rb'

class RGB < Triplet
    [[:r, :x], [:g, :y], [:b, :z]].each{|ar|
        eval("alias #{ar[0]} #{ar[1]}")
        eval("alias #{ar[0]}= #{ar[1]}=")
    }

    def initialize(init_value = 0)
        super
    end
end