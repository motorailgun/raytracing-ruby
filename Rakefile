require "minitest/test_task"

Minitest::TestTask.create(:test) do |t|
    t.libs << "test"
    t.libs << "lib"
    t.warning = false
    t.test_globs = ["**/*_test.rb"]
  end
