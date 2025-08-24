require 'test_helper'
require 'date'

class TestWeightLogger < Minitest::Test
  def setup
    super
    @buncho_name = 'yuki'
    @weight_dir = File.join(@test_dir, 'data', 'weight')
    FileUtils.mkdir_p(@weight_dir)
    @file = File.join(@weight_dir, "#{@buncho_name}.csv")
  end

  def test_add_weight_with_default_date
    weight_logger = Buncho::WeightLogger.new(@buncho_name, @weight_dir)
    weight = 25
    today = Date.today

    weight_logger.add(weight)
    weight_logger.close

    file_content = File.read(@file)
    expected = "#{today},25\n"
    assert_equal expected, file_content
  end

  def test_add_weight_with_specific_date
    weight_logger = Buncho::WeightLogger.new(@buncho_name, @weight_dir)
    weight = 26
    date = Date.new(2025, 8, 20)

    weight_logger.add(weight, date)
    weight_logger.close

    file_content = File.read(@file)
    expected = "2025-08-20,26\n"
    assert_equal expected, file_content
  end

  def test_add_multiple_weights
    weight_logger = Buncho::WeightLogger.new(@buncho_name, @weight_dir)

    date1 = Date.new(2025, 8, 20)
    date2 = Date.new(2025, 8, 21)
    weight1 = 25
    weight2 = 26

    weight_logger.add(weight1, date1)
    weight_logger.add(weight2, date2)
    weight_logger.close

    file_content = File.read(@file)
    expected = "2025-08-20,25\n2025-08-21,26\n"
    assert_equal expected, file_content
  end

  def test_show_with_empty_file
    weight_logger = Buncho::WeightLogger.new(@buncho_name, @weight_dir)

    expected = "yuki's weights:\n"

    assert_output(expected) do
      weight_logger.show
    end
  end

  def test_formatted_rows_returns_recent_data_first
    # 時系列データを準備
    lines = [
      { date: Date.new(2025, 8, 20), weight: 24 },
      { date: Date.new(2025, 8, 21), weight: 25 },
      { date: Date.new(2025, 8, 22), weight: 24 },
      { date: Date.new(2025, 8, 23), weight: 25 },
      { date: Date.new(2025, 8, 24), weight: 26 }
    ]

    write_lines = lines.map { |d| "#{d[:date]},#{d[:weight]}" }.join("\n") + "\n"
    File.write(@file, write_lines)

    weight_logger = Buncho::WeightLogger.new(@buncho_name, @weight_dir)

    result = weight_logger.formatted_rows(3)

    expected = ["2025-08-24,26", "2025-08-23,25", "2025-08-22,24"]
    assert_equal expected, result
  end

  def test_formatted_rows_with_limit_larger_than_data
    data = prepare_weight_data(3)
    File.write(@file, data)

    weight_logger = Buncho::WeightLogger.new(@buncho_name, @weight_dir)

    result = weight_logger.formatted_rows(10)

    assert_equal 3, result.length
  end

  def test_formatted_rows_with_zero_limit
    data = prepare_weight_data(5)
    File.write(@file, data)

    weight_logger = Buncho::WeightLogger.new(@buncho_name, @weight_dir)

    result = weight_logger.formatted_rows(0)

    assert_equal [], result
  end

  def test_formatted_rows_empty_file
    weight_logger = Buncho::WeightLogger.new(@buncho_name, @weight_dir)

    result = weight_logger.formatted_rows(10)

    assert_equal [], result
  end

  def test_add_negative_weight
    weight_logger = Buncho::WeightLogger.new(@buncho_name, @weight_dir)
    weight = -5.0

    weight_logger.add(weight)
    weight_logger.close

    file_content = File.read(@file)
    assert_includes file_content, ''
  end

  def test_add_zero_weight
    weight_logger = Buncho::WeightLogger.new(@buncho_name, @weight_dir)
    weight = 0

    weight_logger.add(weight)
    weight_logger.close

    file_content = File.read(@file)
    assert_includes file_content, ''
  end

  def test_show_formats_output_correctly
    date = Date.new(2025, 8, 23)
    weight = 25
    data = "#{date},#{weight}\n"
    File.write(@file, data)

    weight_logger = Buncho::WeightLogger.new(@buncho_name, @weight_dir)

    expected = "yuki's weights:\n2025-08-23: 25g\n"

    assert_output(expected) do
      weight_logger.show
    end
  end

  def test_multiple_bunchos_separate_files
    buncho1 = 'yuki'
    buncho2 = 'sora'

    weight_logger1 = Buncho::WeightLogger.new(buncho1, @weight_dir)
    weight_logger2 = Buncho::WeightLogger.new(buncho2, @weight_dir)

    weight_logger1.add(25)
    weight_logger2.add(23)
    weight_logger1.close
    weight_logger2.close

    file1 = File.join(@weight_dir, "#{buncho1}.csv")
    file2 = File.join(@weight_dir, "#{buncho2}.csv")

    assert File.exist?(file1)
    assert File.exist?(file2)

    file_content1 = File.read(file1)
    file_content2 = File.read(file2)

    assert_includes file_content1, "25"
    assert_includes file_content2, "23"
  end

  # テストデータを生成するヘルパーメソッド
  def prepare_weight_data(count)
    date = Date.new(2025, 8, 1)
    weight = 25

    (0...count).map do |i|
      date = date + i
      "#{date},#{weight}"
    end.join("\n") + "\n"
  end
end
