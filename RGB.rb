require './Triplet.rb'

class RGB < Triplet
    def initialize(init_value = 0)
        super

        [[:r, :x], [:g, :y], [:b, :z]].each{|ar|
            eval("alias #{ar[0]} #{ar[1]}")
            eval("alias #{ar[0]}= #{ar[1]}=")
        }
    end
end