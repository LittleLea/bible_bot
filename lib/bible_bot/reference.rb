module BibleBot
  # A Reference represents a range of verses.
  class Reference
    attr_reader :start_verse # @return [BibleBot::Verse]
    attr_reader :end_verse # @return [BibleBot::Verse]

    # Initialize a {BibleBot::Reference} from {BibleBot::Verse} IDs. If no end_verse_id is provided, it will
    # set end_verse to equal start_verse.
    #
    # @param start_verse_id [Integer]
    # @param end_verse_id [Integer]
    # @return [BibleBot::Reference]
    # @example
    #   BibleBot::Reference.from_verse_ids(1001001, 1001010) #=> (Gen 1:1-10)
    def self.from_verse_ids(start_verse_id, end_verse_id=nil)
      new(
        start_verse: Verse.from_id(start_verse_id),
        end_verse: Verse.from_id(end_verse_id || start_verse_id),
      )
    end

    # Parse text into an array-like object of scripture References.
    #
    # @param text [String] ex: "John 1:1 is the first but Romans 8:9-10 is another."
    # @param validate [Boolean, :raise_errors]
    #   * true - Skip invalid references (default)
    #   * false - Include invalid references
    #   * :raise_errors - Raise error if any references are invalid
    # @return [BibleBot::References<BibleBot::Reference>]
    def self.parse(text, validate: true)
      references = if text.nil? || text.strip == ""
        []
      else
        ReferenceMatch.scan(text).map(&:reference).select do |ref|
          ref.validate! if validate == :raise_errors

          !validate || ref.valid?
        end
      end

      return References.new(references)
    end

    # Normalizes a scripture reference string into properly formatted references
    #
    # @param text [String] ex: ' Ps  1; Gen 1 -2'
    # @return [String]
    # @example
    #   BibleBot::Reference.normalize(' Ps  1; Gen 1 -2')
    #   #=> 'Psalm 1; Genesis 1-2'
    def self.normalize(text)
      self.parse(text).formatted
    end

    # Returns an array of string scripture references, where each reference contains
    # the verses of just 1 chapter.
    #
    # @param text [String] ex: ' Ps  1; Gen 1:4-2:6'
    # @return [Array<String>]
    # @example
    #   BibleBot::Reference.normalize_by_chapter(' Ps  1; Gen 1:4-2:6')
    #   #=> 'Psalm 1; '
    def self.normalize_by_chapter(text)
      self.parse(text).chapters.map(&:formatted)
    end

    # @param start_verse [BibleBot::Verse]
    # @param end_verse [BibleBot::Verse] Defaults to start_verse if no end_verse is provided
    def initialize(start_verse:, end_verse: nil)
      @start_verse = start_verse
      @end_verse   = end_verse || start_verse
      @verses = nil
    end

    # Returns a boolean if the reference contains an apocryphal book
    #
    # @return [Boolean]
    def contains_apocrypha?
      # Since references are a range and apocryphal books come after non-apocryphal books,
      # we can simply check the end verse's book to see whether it's apocryphal or not.
      end_verse.book.apocryphal?
    end

    # Returns a formatted string of the {BibleBot::Reference}.
    #
    # @return [String]
    # @example
    #   reference.formatted #=> "Genesis 2:4-5:9"
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

    # @return [Boolean]
    def same_start_and_end_book?
      start_verse.book == end_verse&.book
    end

    # @return [Boolean]
    def same_start_and_end_chapter?
      same_start_and_end_book? &&
      start_verse.chapter_number == end_verse&.chapter_number
    end

    # One or multiple full chapters.
    #
    # @return [Boolean]
    def full_chapters?
      start_verse.verse_number == 1 && end_verse&.last_verse_in_chapter?
    end

    # @return [string]
    def to_s
      "BibleBot::Reference — #{formatted}"
    end

    # Returns true if the given verse is within the start and end verse of the BibleBot::Reference.
    #
    # @param verse [BibleBot::Verse]
    # @return [Boolean]
    def includes_verse?(verse)
      return false unless verse.is_a?(Verse)

      start_verse <= verse && verse <= end_verse
    end

    # Return true if the two references contain any of the same verses.
    # @param other [BibleBot::Reference]
    # @return [Boolean]
    def intersects_reference?(other)
      return false unless other.is_a?(Reference)

      start_verse <= other.end_verse && end_verse >= other.start_verse
    end

    # Returns an array of all the verses contained in the BibleBot::Reference.
    #
    # @return [Array<BibleBot::Verse>]
    def verses
      return @verses if @verses

      @verses = []
      return @verses unless valid?

      verse = start_verse

      loop do
        @verses << verse
        break if end_verse.nil? || verse == end_verse
        verse = verse.next_verse
      end

      @verses
    end

    # @return [Hash]
    def inspect
      {
        start_verse: start_verse&.formatted,
        end_verse: end_verse&.formatted,
      }
    end

    # @return [Boolean]
    def valid?
      start_verse&.valid? && end_verse&.valid? && end_verse >= start_verse
    end

    # Raises error if reference is invalid
    def validate!
      start_verse&.validate!
      end_verse&.validate!
      raise InvalidReferenceError.new "Reference is not vaild: #{inspect}" unless valid?
    end
  end
end
