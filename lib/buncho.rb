# frozen_string_literal: true

require_relative "buncho/version"

module Buncho
  class Error < StandardError; end

  Dir[File.expand_path("buncho/**/*.rb", __dir__)].sort.each do |file|
    require file
  end
end
