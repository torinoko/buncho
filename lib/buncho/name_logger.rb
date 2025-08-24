module Buncho
  class NameLogger < BaseLogger
    DATA_FILE = File.expand_path("../../../data/names.txt", __FILE__)

    attr_reader :names

    def initialize(file_path = DATA_FILE)
      super(file_path)
      @names = read_lines.each_with_index.to_h { |val, i| [i + 1, val.chomp] }
    end

    def add(name)
      return nil if name.nil? || name.empty?
      return name if name_exists?(name)

      @io.write("#{name}\n")
      index = @names.keys.max.to_i + 1
      @names[index] = name
      name
    end

    def show
      puts "Buncho's List:"
      puts formatted_rows
    end

    def name_exists?(name)
      @names.value?(name)
    end

    def formatted_rows
      @names.map { |k, v| "#{k}. #{v}" }
    end
  end
end
