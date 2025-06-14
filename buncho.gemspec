# frozen_string_literal: true

require_relative "lib/buncho/version"

Gem::Specification.new do |spec|
  spec.name = "buncho"
  spec.version = Buncho::VERSION
  spec.authors = ["tadaaki"]

  spec.summary = "gem for Buncho Body Weight Management"
  spec.description = "This is a Ruby gem for managing the body weight of Buncho."
  spec.homepage = "https://kamazuni-marunomi.com/"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/torinoko/buncho"
  spec.metadata["changelog_uri"] = "https://github.com/torinoko/buncho/blob/main/CHANGELOG.md"

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "bin"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.executables   = ["buncho"]
end
