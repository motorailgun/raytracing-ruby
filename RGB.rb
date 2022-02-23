require './Triplet.rb'

class RGB < Triplet
    def initialize(init_value: 0)
        [[:r, "@x"], [:g, "@y"], [:b, "@z"]].each{|ar|
            alias_method ar[0], ar[1]
        }

        super
    end
end