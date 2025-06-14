require File.expand_path("../../test_helper", __dir__)

class TestWeightLogger < Minitest::Test
  def setup
    name = 'sora'
    dir_path = File.expand_path("../../../data/weight/", __FILE__)
    file_path = "#{dir_path}/#{name}.csv"
    File.delete(file_path) if File.exist?(file_path)
    @logger = ::Buncho::WeightLogger.new(name, dir_path)
  end

  def test_formatted_rows
    @logger.add(25)
    assert_equal "#{Date.today},25", @logger.formatted_rows(10)[0]
    assert_equal 1, @logger.formatted_rows(10).size

    20.times do |n|
      @logger.add(25)
    end
    assert_equal 10, @logger.formatted_rows(10).size
  end
end
