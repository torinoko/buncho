require File.expand_path("../../test_helper", __dir__)

class TestWeightLog < Minitest::Test
  def setup
    name = 'sora'
    dir_path = File.expand_path("../../../data/weight/", __FILE__)
    file_path = "#{dir_path}/#{name}.csv"
    File.delete(file_path) if File.exist?(file_path)
    @weight_log = ::Buncho::WeightLog.new(name, dir_path)
  end

  def test_formatted_rows
    @weight_log.add(25)
    assert_equal "#{Date.today},25", @weight_log.formatted_rows(10)[0]
    assert_equal 1, @weight_log.formatted_rows(10).size

    20.times do |n|
      @weight_log.add(25)
    end
    assert_equal 10, @weight_log.formatted_rows(10).size
  end
end
