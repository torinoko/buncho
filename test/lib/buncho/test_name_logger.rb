require File.expand_path("../../test_helper", __dir__)

require 'test_helper'

class TestNameLogger < Minitest::Test
  def setup
    super
    @file = temp_file_path('names.txt')
    write_test_data(@file, '')
  end

  def test_initialize_with_empty_file
    name_logger = Buncho::NameLogger.new(@file)

    assert_equal({}, name_logger.names)
  end

  def test_add_new_name_to_empty_file
    name_logger = Buncho::NameLogger.new(@file)

    result = name_logger.add("yuki")
    name_logger.close

    assert_equal "yuki", result
    assert_equal({1 => "yuki"}, name_logger.names)

    file_content = File.read(@file)
    assert_equal "yuki\n", file_content
  end

  def test_add_new_name_to_existing_data
    expected_names = { 1 => "yuki", 2 => "sora", 3 => "taro" }
    data = "yuki\nsora\n"
    write_test_data(@file, data)

    name_logger = Buncho::NameLogger.new(@file)
    result = name_logger.add("taro")
    name_logger.close

    assert_equal "taro", result
    assert_equal expected_names, name_logger.names

    file_content = File.read(@file)
    assert_equal "yuki\nsora\ntaro\n", file_content
  end

  def test_initialize_with_existing_data
    expected_names = { 1 => "yuki", 2 => "sora", 3 => "taro" }
    data = "yuki\nsora\ntaro\n"
    write_test_data(@file, data)

    name_logger = Buncho::NameLogger.new(@file)

    assert_equal expected_names, name_logger.names
  end

  def test_add_duplicate_name
    data = "yuki\nsora\n"
    write_test_data(@file, data)

    name_logger = Buncho::NameLogger.new(@file)
    result = name_logger.add("yuki")

    assert_equal "yuki", result

    expected_names = { 1 => "yuki", 2 => "sora" }
    assert_equal expected_names, name_logger.names

    file_content = File.read(@file)
    assert_equal "yuki\nsora\n", file_content
  end

  def test_add_empty_string
    name_logger = Buncho::NameLogger.new(@file)

    result = name_logger.add('')

    assert_nil result
    assert_equal({}, name_logger.names)
  end

  def test_add_nil
    name_logger = Buncho::NameLogger.new(@file)
    result = name_logger.add(nil)

    assert_nil result
    assert_equal({}, name_logger.names)
  end

  def test_name_exists_true
    data = "yuki\nsora\n"
    write_test_data(@file, data)

    name_logger = Buncho::NameLogger.new(@file)

    assert name_logger.name_exists?("yuki")
    assert name_logger.name_exists?("sora")
  end

  def test_name_exists_false
    data = "yuki\nsora\n"
    write_test_data(@file, data)

    name_logger = Buncho::NameLogger.new(@file)

    refute name_logger.name_exists?("taro")
    refute name_logger.name_exists?('')
    refute name_logger.name_exists?(nil)
  end

  def test_show_output
    data = "yuki\nsora\n"
    write_test_data(@file, data)

    name_logger = Buncho::NameLogger.new(@file)
    expected = "Buncho's List:\n1. yuki\n2. sora\n"

    assert_output(expected) do
      name_logger.show
    end
  end

  def test_show_with_empty_list
    name_logger = Buncho::NameLogger.new(@file)
    expected_output = "Buncho's List:\n"

    assert_output(expected_output) do
      name_logger.show
    end
  end

  def test_formatted_rows
    data = "yuki\nsora\ntaro\n"
    write_test_data(@file, data)

    name_logger = Buncho::NameLogger.new(@file)

    result = name_logger.formatted_rows

    assert_instance_of Array, result

    formatted = result.to_a
    expected = ["1. yuki", "2. sora", "3. taro"]
    assert_equal expected, formatted
  end

  def test_formatted_rows_empty
    name_logger = Buncho::NameLogger.new(@file)

    result = name_logger.formatted_rows
    formatted = result.to_a

    assert_empty formatted
  end

  def test_whitespace_handling
    data = " yuki \n sora \n"
    write_test_data(@file, data)

    name_logger = Buncho::NameLogger.new(@file)

    expected_names = { 1 => " yuki ", 2 => " sora " }
    assert_equal expected_names, name_logger.names
  end
end
