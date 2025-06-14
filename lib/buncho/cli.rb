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

        weight = options[:weight]
        resolver = NameResolver.new(logger)
        name = resolver.resolve_name(options[:name])
        weight_logger = WeightLogger.new(name)

        unless weight.nil?
          weight_logger.add(weight)
          puts "#{name}'s weight is #{weight}g."
        end

        if options[:weight_list]
          weight_logger.show
        end
      end
    end
  end
end
