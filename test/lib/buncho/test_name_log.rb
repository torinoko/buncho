require File.expand_path("../../test_helper", __dir__)

class TestNameLog < Minitest::Test
  def setup
    file_path = File.expand_path("../../../data/names.txt", __FILE__)
    File.delete(file_path)
    @name_log = ::Buncho::NameLog.new(file_path)
  end

  def test_name_exists?
    refute @name_log.name_exists?('sora')
    @name_log.add('sora')
    @name_log.add('yuki')
    assert @name_log.name_exists?('sora')
  end

  def test_show
    @name_log.add('sora')
    @name_log.add('yuki')
    assert_equal 2, @name_log.show.size
  end
end
