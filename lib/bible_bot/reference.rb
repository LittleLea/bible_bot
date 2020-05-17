module BibleBot
  class Reference
    attr_reader :start_verse
    attr_reader :end_verse

    def self.from_verse_id(verse_id)
      new(start_verse: Verse.from_id(verse_id))
    end

    def self.from_verse_ids(start_verse_id, end_verse_id)
      new(
        start_verse: Verse.from_id(start_verse_id),
        end_verse: Verse.from_id(end_verse_id),
      )
    end

    # Parse text into an array of scripture References
    #
    # @param text [String] ex: "John 1:1 is the first first but Romans 8:9-10 is another."
    # @param ignore_errors [Bool] default: false
    #     By default, raises the following errors
    #       * InvalidVerseError - If a matching verse is not valid
    #       * InvalidReferenceError - If verses are valid but reference is not
    # @return [Array<Reference>]
    def self.parse(text, ignore_errors: false)
      ReferenceMatch.scan(text).map do |ref_match|
        ref_match.reference(nil_on_error: ignore_errors)
      end.compact
    end

    def initialize(start_verse:, end_verse: nil)
      @start_verse = start_verse
      @end_verse   = end_verse

      raise InvalidReferenceError.new "Reference is not vaild: #{inspect}" unless valid?
    end

    def valid?
      end_verse.nil? || end_verse >= start_verse
    end

    def formatted
      formatted_verses = [start_verse.formatted(include_verse: !full_chapters?)]

      if end_verse && end_verse > start_verse && !(same_start_and_end_chapter? && full_chapters?)
        formatted_verses << end_verse.formatted(
          include_book: !same_start_and_end_book?,
          include_chapter: !same_start_and_end_chapter?,
          include_verse: !full_chapters?,
        )
      end

      formatted_verses.join('-')
    end

    def same_start_and_end_book?
      start_verse.book == end_verse&.book
    end

    def same_start_and_end_chapter?
      same_start_and_end_book? &&
      start_verse.chapter_number == end_verse&.chapter_number
    end

    # One or multiple full chapters
    def full_chapters?
      start_verse.verse_number == 1 && end_verse&.last_verse_in_chapter?
    end

    def to_s
      "BibleBot::Reference — #{formatted}"
    end

    def includes_verse?(verse)
      return false unless verse.is_a?(Verse)

      if end_verse.nil?
        verse == start_verse
      else
        start_verse <= verse && verse <= end_verse
      end
    end

    def intersects_reference?(other)
      start_verse <= (other.end_verse || other.start_verse) &&
      (end_verse || start_verse) >= other.start_verse
    end

    def verses
      return @verses if defined? @verses

      @verses = []
      verse = start_verse

      loop do
        @verses << verse
        break if end_verse.nil? || verse == end_verse
        verse = verse.next_verse
      end

      @verses
    end

    def inspect
      {
        start_verse: start_verse&.formatted,
        end_verse: end_verse&.formatted,
      }
    end
  end
end
