# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bible_bot/version'

Gem::Specification.new do |spec|
  spec.name          = "bible_bot"
  spec.version       = BibleBot::VERSION
  spec.authors       = ["Jeff McFadden"]
  spec.email         = ["jeff@littlelea.co"]
  spec.summary       = 'Bible Verse Parsing, etc.'
  spec.homepage      = "https://github.com/lightstock/bible_bot"
  spec.license       = "MIT"

  spec.required_ruby_version = '>= 3.1'

  spec.files         = Dir.glob('{lib,rbi}/**/*', File::FNM_DOTMATCH)
  spec.bindir        = 'exe'
  spec.executables   = []
  spec.test_files    = []
  spec.require_paths = ["lib"]
  spec.extra_rdoc_files = ['LICENSE', 'README.md']

  spec.add_dependency 'i18n'
end
