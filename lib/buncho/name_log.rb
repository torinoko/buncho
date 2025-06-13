module Buncho
  class NameLog
    DATA_FILE = File.expand_path("../../../data/names.txt", __FILE__)

    attr_reader :names

    def initialize(file_path = DATA_FILE)
      FileUtils.mkdir_p(File.dirname(file_path))
      @io = File.open(file_path, "a+")
      names = @io.read.split("\n")
      @names = names.each_with_index.to_h { |val, i| [i + 1, val.chomp] }
    end

    def name_exists?(name)
      @names.value?(name)
    end

    def add(name)
      return if name_exists?(name)

      @io.write("#{name}\n")
      index = @names.keys.max.to_i + 1
      @names[index] = name
      name
    end

    def show
      @names.each { |k, v| puts "#{k}. #{v}" }
    end
  end
end
