# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bible_bot/version'

Gem::Specification.new do |spec|
  spec.name          = "bible_bot"
  spec.version       = BibleBot::VERSION
  spec.authors       = ["Jeff McFadden"]
  spec.email         = ["jeff@littlelea.co"]
  spec.summary       = %q{Bible Verse Parsing, etc.}
  spec.homepage      = "https://github.com/lightstock/bible_bot"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'rspec', '~> 3.5.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'irb'
end
