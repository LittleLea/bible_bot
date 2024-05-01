# Gem under test
require 'bible_bot'

include BibleBot

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
  config.color = true

  config.around(:each, :with_apocrypha) do |ex|
    old_include = BibleBot.include_apocryphal_content?
    BibleBot.include_apocryphal_content = true

    ex.run

    BibleBot.include_apocryphal_content = old_include
  end
end
