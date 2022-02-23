require './Triplet.rb'

class RGB < Triplet
    def initialize(init_value: 0)
        [[:r, "@x"], [:g, "@y"], [:b, "@z"]].each{|ar|
            define_singleton_method(ar[0]){
                eval("#{ar[1]}")
            }
        }

        super
    end
end