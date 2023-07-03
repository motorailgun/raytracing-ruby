require 'minitest/autorun'
require_relative './Vector3D'
require_relative './Ray'

class RayTest < Minitest::Test
    def test_at
        origin = Vector3D.new(0.0, 0.0, 0.0)
        direction = Vector3D.new(1.0, 1.0, 1.0)

        ray = Ray.new(origin, direction)
        at_ten = ray.at(10.0)
        assert_equal(at_ten.x, 10.0)
        assert_equal(at_ten.y, 10.0)
        assert_equal(at_ten.z, 10.0)
    end
end
