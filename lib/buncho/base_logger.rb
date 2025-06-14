module Buncho
  class BaseLogger
    attr_reader :path

    def initialize(path)
      @path = File.expand_path(path, __FILE__)
      @io = File.open(path, "a+")
    end

    def read_lines
      @io.rewind
      File.exist?(@path) ? @io.read.split("\n") : []
    end
  end
end