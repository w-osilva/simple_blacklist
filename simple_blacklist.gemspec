# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_blacklist/version'

Gem::Specification.new do |spec|
  spec.name          = "simple_blacklist"
  spec.version       = SimpleBlacklist::VERSION
  spec.license       = "MIT"
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ["Washington Silva"]
  spec.email         = ["w-osilva@hotmail.com"]
  spec.homepage      = ""
  spec.rubyforge_project = "simple_blacklist"
  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = `git ls-files -- {test,spec}/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.required_ruby_version = '>= 2.0.0'

  spec.summary       = %q{Simple Blacklist to sanitize strings}
  spec.description   = %q{This project is designed to make easy the task of sanitizing string that contains words not allowed. }

  spec.add_dependency "bundler"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
