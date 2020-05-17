module BibleBot
  class Parser
    # Extract an array of scripture references from a block of text
    def extract(text, ignore_errors: false)
      references = []
      regex_matches(text).each do |match|
        begin
          references << MatchToReference.new(match).reference
        rescue BibleBotError => e
          raise e unless ignore_errors
          next
        end
      end

      return references
    end

    private

    def regex_matches(text)
      Array.new.tap { |matches| text.scan(Bible.new.scripture_re){ matches << $~ } }
    end
  end
end
