module Buncho
  class NameResolver
    def initialize(logger)
      @logger = logger
    end

    def resolve_name(name)
      name&.chomp!
      names = @logger.names

      if names.value?(name)
        return name
      end

      if name && !names.value?(name)
        @logger.add(name)
        return name
      end

      if names.nil? || names.empty?
        puts "Error: Please register your buncho's name."
        puts "Example: buncho -n NAME"
        exit 1
      end

      if names.size == 1
        return names.values.first
      end

      puts "Which buncho's data do you want to use? Enter the number."
      names.each { |k, v| puts "#{k} #{v}" }
      input = STDIN.gets.chomp
      names[input.to_i]
    end
  end
end