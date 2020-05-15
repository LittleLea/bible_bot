module BibleBot
  class BibleBotError < StandardError
  end

  class InvalidReferenceError < BibleBotError
  end

  class ScriptureError < BibleBotError
  end
end
