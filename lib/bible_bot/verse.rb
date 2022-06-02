module BibleBot
  # Verse represents a single verse in the bible.
  class Verse
    include Comparable

    attr_reader :book # @return [Book]
    attr_reader :chapter_number # @return [Integer]
    attr_reader :verse_number # @return [Integer]

    # Turns an Inteter into a Verse
    # For more details, see note above the `id` method.
    #
    # @param id [Integer]
    # @return [Verse]
    # @example
    #   Verse.from_id(19_105_001) #=> <Verse book="Psalms" chapter_number=105 verse_number=1>
    def self.from_id(id)
      return from_string_id(id) if id.is_a?(String)
      return nil if id.nil?
      raise BibleBot::InvalidVerseError unless id.is_a?(Integer)

      book_id        = id / 1_000_000
      chapter_number = id / 1_000 % 1_000
      verse_number   = id % 1_000
      book           = BibleBot::Book.find_by_id(book_id)

      new(book: book, chapter_number: chapter_number, verse_number: verse_number)
    end

    # @param book [Book]
    # @param chapter_number [Integer]
    # @param verse_number [Integer]
    def initialize(book:, chapter_number:,  verse_number:)
      @book = book
      @chapter_number = chapter_number
      @verse_number = verse_number
    end

    # Returns an Integer in the from of
    #
    #   |- book.id
    #   |   |- chapter_number
    #   |   |   |- verse_number
    #   XX_XXX_XXX
    #
    # Storing as an Integer makes it super convenient to store in a database
    # and compare verses and verse ranges using simple database queries
    #
    # @return [Integer]
    # @example
    #   verse.id #=> 19_105_001
    #                 #-> this represents "Psalm 105:1"
    def id
      @id ||= "#{book.id}#{chapter_number.to_s.rjust(3, '0')}#{verse_number.to_s.rjust(3, '0')}".to_i
    end

    # @deprecated Use {id} instead
    # @return [String] ex: "psalms-023-001"
    def string_id
      "#{book.string_id}-#{chapter_number.to_s.rjust(3, '0')}-#{verse_number.to_s.rjust(3, '0')}"
    end

    # The Comparable mixin uses this to define all the other comparable methods
    #
    # @param other [Verse]
    # @return [Integer] Either -1, 0, or 1
    #   * -1: this verse is less than the other verse
    #   * 0: this verse is equal to the other verse
    #   * 1: this verse is greater than the other verse
    def <=>(other)
      id <=> other.id
    end

    # @param include_book [Boolean]
    # @param include_chapter [Boolean]
    # @param include_verse [Boolean]
    # @return [String]
    # @example
    #   verse.formatted #=> "Genesis 5:23"
    def formatted(include_book: true, include_chapter: true, include_verse: true)
      str = String.new # Using String.new because string literals will be frozen in Ruby 3.0
      str << "#{book.formatted_name} " if include_book

      str << "#{chapter_number}" if include_chapter
      str << ":" if include_chapter && include_verse
      str << "#{verse_number}" if include_verse

      str.strip.freeze
    end

    # Returns next verse. It will reach into the next chapter or the next book
    # until it gets to the last verse in the bible,
    # at which point it will return nil.
    #
    # @return [Verse, nil]
    def next_verse
      return Verse.new(book: book, chapter_number: chapter_number, verse_number: verse_number + 1) unless last_verse_in_chapter?
      return Verse.new(book: book, chapter_number: chapter_number + 1, verse_number: 1) unless last_chapter_in_book?
      return Verse.new(book: book.next_book, chapter_number: 1, verse_number: 1) if book.next_book
      nil
    end

    # @return [Boolean]
    def last_verse_in_chapter?
      verse_number == book.chapters[chapter_number - 1]
    end

    # @return [Boolean]
    def last_chapter_in_book?
      chapter_number == book.chapters.length
    end

    # @return [Hash]
    def inspect
      {
        book: book&.name,
        chapter_number: chapter_number,
        verse_number: verse_number
      }
    end

    # @return [Boolean]
    def valid?
      book.is_a?(BibleBot::Book) &&
      chapter_number.is_a?(Integer) && chapter_number >= 1 && chapter_number <= book.chapters.length &&
      verse_number.is_a?(Integer) && verse_number >= 1 && verse_number <= book.chapters[chapter_number-1]
    end

    # Raises error if reference is invalid
    def validate!
      raise InvalidVerseError.new "Verse is not valid: #{inspect}" unless valid?
    end

    private

    # This gets called by {from_id} to allow it to be backwards compatible for a while.
    # @deprecated Use {from_id} instead.
    # @param verse_id [String] ex: "genesis-001-001"
    # @return [Verse] ex: <Verse book="Genesis" chapter_number=1 verse_number=1>
    def self.from_string_id(string_id)
      parts = string_id.split( '-' )

      book_name      = parts[0].gsub( '_', ' ' )
      chapter_number = parts[1].to_i
      verse_number   = parts[2].to_i

      book = BibleBot::Book.find_by_name(book_name)
      new(book: book, chapter_number: chapter_number, verse_number: verse_number)
    end
  end
end
