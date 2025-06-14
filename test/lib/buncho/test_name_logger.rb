require File.expand_path("../../test_helper", __dir__)

class TestNameLogger < Minitest::Test
  def setup
    file_path = File.expand_path("../../../data/names.txt", __dir__)
    File.delete(file_path) if File.exist?(file_path)
    @logger = ::Buncho::NameLogger.new(file_path)
  end

  def test_name_exists?
    refute @logger.name_exists?('sora')
    @logger.add('sora')
    @logger.add('yuki')
    assert @logger.name_exists?('sora')
  end

  def test_formatted_rows
    @logger.add('sora')
    @logger.add('yuki')
    assert_equal 'sora', @logger.formatted_rows[1]
    assert_equal 2, @logger.formatted_rows.size
  end
end
