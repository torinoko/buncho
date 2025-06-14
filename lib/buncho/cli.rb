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
        weight = options[:weight]
        names = logger.names
        puts names

        if name && !names.value?(name)
          logger.add(name)
        end

        if names.nil? || names.empty?
          puts "Error: Please register your buncho_old's name."
          puts "Example: buncho_old -n NAME"
          exit 1
        end

        if names.size == 1
          name = names.values.first
        else
          puts "Which buncho_old's data do you want to use? Enter the number."
          names.each { |k, v| puts "#{k} #{v}" }
          input = STDIN.gets.chomp
          name = names[input.to_i]
        end

        weight_logger = WeightLogger.new(name)

        unless weight.nil?
          weight_logger.add(weight)
          puts "#{name}'s weight is #{weight}g."
        end
      end
    end
  end
end
