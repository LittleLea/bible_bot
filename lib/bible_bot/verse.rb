module BibleBot
  class Verse
    include Comparable

    attr_reader :book
    attr_reader :chapter_number
    attr_reader :verse_number

    def self.from_id(id)
      return deprecated_from_verse_id(id) if id.is_a?(String)
      return nil if id.nil?
      raise BibleBot::InvalidVerseError unless id.is_a?(Integer)

      book_id        = id / 1_000_000
      chapter_number = id / 1_000 % 1_000
      verse_number   = id % 1_000
      book           = BibleBot::Book.find_by_id(book_id)

      new(book: book, chapter_number: chapter_number, verse_number: verse_number)
    end

    # Deprecated
    # This uses the old string format.
    # Moving forward you should use the new integer format instead.
    def self.deprecated_from_verse_id(verse_id)
      parts = verse_id.split( '-' )

      book_name      = parts[0].gsub( '_', ' ' )
      chapter_number = parts[1].to_i
      verse_number   = parts[2].to_i

      book = BibleBot::Bible.books.select{ |b| b.name.downcase == book_name }.first

      # This Error is now deprecated, use InvalidVerseError instead
      raise BibleBot::InvalidVerseID if book.nil?

      new(book: book, chapter_number: chapter_number, verse_number: verse_number)
    end

    def initialize(book: nil, chapter_number: nil,  verse_number: nil)
      @book = book
      @chapter_number = chapter_number
      @verse_number = verse_number

      raise InvalidVerseError unless valid?
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
    # Example:
    #   19_105_001 -> Psalm 105:1
    def id
      @id ||= "#{book.id}#{chapter_number.to_s.rjust(3, '0')}#{verse_number.to_s.rjust(3, '0')}".to_i
    end

    # deprecated, use id instead
    def verse_id
      "#{book.name.downcase.gsub(' ', '_')}-#{chapter_number.to_s.rjust(3, '0')}-#{verse_number.to_s.rjust(3, '0')}"
    end

    def <=>(other)
      id <=> other.id
    end

    def formatted(include_book: true, include_chapter: true, include_verse: true)
      str = String.new # Using String.new because string literals will be frozen in Ruby 3.0
      str << "#{book.formatted_name} " if include_book

      if book.single_chapter?
        str << "#{verse_number}" if include_verse
      else
        str << "#{chapter_number}" if include_chapter
        str << ":" if include_chapter && include_verse
        str << "#{verse_number}" if include_verse
      end

      str.strip.freeze
    end

    def next_verse
      return Verse.new(book: book, chapter_number: chapter_number, verse_number: verse_number + 1) unless last_verse_in_chapter?
      return Verse.new(book: book, chapter_number: chapter_number + 1, verse_number: 1) unless last_chapter_in_book?
      return Verse.new(book: book.next_book, chapter_number: 1, verse_number: 1) if book.next_book
      nil
    end

    def last_verse_in_chapter?
      verse_number == book.chapters[chapter_number - 1]
    end

    def last_chapter_in_book?
      chapter_number == book.chapters.length
    end

    private

    # This private because it is called on initialize and raises an error if not valid
    # So any initialized Verse will always be valid.
    def valid?
      book.is_a?(BibleBot::Book) &&
      chapter_number.is_a?(Integer) && chapter_number >= 1 && chapter_number <= book.chapters.length &&
      verse_number.is_a?(Integer) && verse_number >= 1 && verse_number <= book.chapters[chapter_number-1]
    end
  end
end
