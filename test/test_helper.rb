$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require 'buncho'
require 'minitest/autorun'
require 'pry'
require_relative "../lib/buncho"

class Minitest::Test
  def setup
    @test_dir = Dir.mktmpdir
    Dir.chdir(@test_dir)
    FileUtils.mkdir_p('data')
  end

  def teardown
    FileUtils.rm_rf(@test_dir) if @test_dir
  end

  def temp_file_path(filename = 'test_names.txt')
    File.join(@test_dir, 'data', filename)
  end

  def write_test_data(file_path, data)
    File.write(file_path, data)
  end
end