require 'support/helpers'

# Support gems


# Gem under test
require 'bible_bot'

include BibleBot
include Helpers

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
  config.color = true
end
