#From forgeapps/scripture_parser v0.0.1
module BibleBot
  class Errors
    class InvalidReferenceError < StandardError
    end

    class ScriptureError < StandardError
    end
  end
end
