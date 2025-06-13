#!/usr/bin/env ruby

require "optparse"

module Buncho
  class CLI
    class << self
      def run(argv)
        options = {}

        OptionParser.new do |opts|
          opts.on("-n NAME", "--name", "Buncho's name (Example: buncho -n Sora)") { |v| options[:name] = v }
          opts.on("-h", "--help", "Show this help message") do
            puts opts
            exit
          end
        end.parse!

      end
    end
  end
end
