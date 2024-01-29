require "ostruct"
require "bible_bot/version"
require "bible_bot/book"
require "bible_bot/bible"
require "bible_bot/errors"
require "bible_bot/verse"
require "bible_bot/reference"
require "bible_bot/reference_match"
require "bible_bot/references"

module BibleBot
  DEFAULTS = {
    include_apocryphal_content: false
  }

  def self.options
    @options ||= OpenStruct.new(DEFAULTS.dup)
  end

  def self.options=(opts)
    @options = opts
  end

  ##
  # Configuration for BibleBot, use like:
  #
  #   BibleBot.configure do |config|
  #     config.include_apocryphal_content = true
  #   end
  def self.configure
    yield(options)
  end

  def self.include_apocryphal_content?
    !!self.options.include_apocryphal_content
  end

  def self.include_apocryphal_content=(inc)
    self.options.include_apocryphal_content = (inc == true)

    # We need to reset the stored regexps because they take content into account.
    BibleBot::Bible.reset_regular_expressions
  end
end
