require './rtweekend'

# image properties
aspect_ratio = 16.0 / 9.0
image_width = 400
image_height = Integer(image_width / aspect_ratio)

# world
world = HittableList.new
world.add(Sphere.new(p3d(0.0, 0.0, -1.0), 0.5))
world.add(Sphere.new(p3d(0.0, -100.5, -1.0), 100.0))

# camera properties
camera = Camera.new(:height => 2.0, :focal_length => 1.0)
samples = 50

max_depth = 25
