#!/usr/bin/env ruby

require "optparse"

module Buncho
  class CLI
    class << self
      def run(argv)
        options = {}
        logger = NameLogger.new

        OptionParser.new do |opts|
          opts.on("-n NAME", "--name", "Buncho's name (Example: buncho -n Sora)") { |v| options[:name] = v }
          opts.on("-w WEIGHT", "--wieght", "Buncho's Weight (Example: buncho -w 25)") { |v| options[:weight] = v }
          opts.on("-l", "--weight-list", "Show list of registered buncho weights") { |v| options[:weight_list] = v }
          opts.on("-h", "--help", "Show this help message") do
            puts opts
            exit
          end
        end.parse!

        name = options[:name]
        names = logger.names
        puts names

        if name && !names.value?(name)
          logger.add(name)
        end
      end
    end
  end
end
