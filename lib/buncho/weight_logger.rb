require 'date'

module Buncho
  class WeightLogger
    DATA_DIR_PATH = File.expand_path("../../../data/weight/", __FILE__)

    def initialize(name, file_path = DATA_DIR_PATH)
      file_path = "#{file_path}/#{name}.csv"
      @io = File.open(file_path, "a+")
      @name = name
    end

    def add(weight, date = nil)
      date = Date.today if date.nil?
      line = [date, weight].join(',')
      @io.write("#{line}\n")
    end

    def show(n = 10)
      puts "#{@name}'s weights:"
      formatted_rows(n).each do |line|
        line = line.split(",")
        puts "#{line[0]}: #{line[1]}g"
      end
    end
    def formatted_rows(n)
      @io.rewind
      weights = @io.read.split("\n")
      weights.reverse.first(n)
    end
  end
end

