# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "viberator/version"

Gem::Specification.new do |spec|
  spec.name          = "viberator"
  spec.version       = Viberator::VERSION
  spec.authors       = ["Aleksey V Zapparov"]
  spec.email         = ["ixti@member.fsf.org"]
  spec.summary       = "viberator-#{Viberator::VERSION}"
  spec.description   = "Dumps Viber chat logs into pretty-formatted HTML"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ["lib"]

  spec.required_ruby_version = "~> 2.1"

  spec.add_runtime_dependency "slim"
  spec.add_runtime_dependency "sequel"
  spec.add_runtime_dependency "sqlite3"
  spec.add_runtime_dependency "highline"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
