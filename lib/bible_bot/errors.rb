module BibleBot
  class BibleBotError < StandardError
  end

  class InvalidReferenceError < BibleBotError
  end

  class InvalidVerseError < BibleBotError
  end

  # Deprecated, use InvalidVerseError instead
  class InvalidVerseID < BibleBotError
  end

  # Deprecated, it looks like this was never used?
  class ScriptureError < BibleBotError
  end
end
