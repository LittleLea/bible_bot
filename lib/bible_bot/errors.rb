module BibleBot
  class BibleBotError < StandardError
  end

  # Raised if initialized Reference is not valid.
  # @example
  #   "Genesis 4-2"
  class InvalidReferenceError < BibleBotError
  end

  # Raised if initialized Verse is not valid.
  # In other words, if a chapter or verse are referenced that don't actually exist.
  # @example
  #   "Genesis 100:2"
  class InvalidVerseError < BibleBotError
  end
end
