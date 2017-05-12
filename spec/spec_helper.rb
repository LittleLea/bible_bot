require 'support/helpers'

# Support gems


# Gem under test
require 'bible_verse'

include BibleVerse
include Helpers

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
  config.color = true
end
