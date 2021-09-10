module BibleBot
  # Represents one of the 66 books in the Bible (Genesis - Revelation), or one of the books in the Apocrypha.
  # You should never need to initialize a Book, they are initialized in {Bible}.
  class Book
    attr_reader :id # @return [Integer]
    attr_reader :name # @return [String]
    attr_reader :abbreviation # @return [String]
    attr_reader :regex # @return [String]
    attr_reader :chapters # @return [Array<Integer>]
    attr_reader :testament # @return [String]
    attr_reader :bible # @return [Boolean]
    attr_reader :apocrypha # @return [Boolean]

    # Uses the same Regex pattern to match as we use in {Reference.parse}.
    # So this supports the same book name abbreviations.
    #
    # @param name [String]
    # @return [Book]
    # @example
    #   Book.find_by_name("Genesis")
    def self.find_by_name(name)
      return nil if name.nil? || name.strip == ""

      Bible.books.find { |book| name.match(Regexp.new('\b'+book.regex+'\b', Regexp::IGNORECASE)) }
    end

    # Find by the Book ID defined in {Bible}.
    #
    # @param id [Integer]
    # @return [Book]
    def self.find_by_id(id)
      Bible.books.find { |book| book.id == id }
    end

    def initialize(id:, name:, abbreviation:, regex:, chapters: [] , testament:, bible:, apocrypha:)
      @id = id
      @name = name
      @abbreviation = abbreviation
      @regex = regex
      @chapters = chapters
      @testament = testament
      @bible = bible
      @apocrypha = apocrypha
    end

    # @return [String]
    def formatted_name
      case name
      when 'Psalms' then 'Psalm'
      else name
      end
    end

    # Single chapter book like Jude
    # @return [Boolean]
    def single_chapter?
      chapters.length == 1
    end

    # A reference containing the entire book
    # @return [Reference]
    def reference
      @reference ||= Reference.new(start_verse: start_verse, end_verse: end_verse)
    end

    # @return [Verse]
    def start_verse
      @first_verse ||= Verse.from_id("#{id}001001".to_i)
    end

    # @return [Verse]
    def end_verse
      @last_verse ||= Verse.from_id(
        "#{id}#{chapters.length.to_s.rjust(3, '0')}#{chapters.last.to_s.rjust(3, '0')}".to_i
      )
    end

    # @return [Book, nil]
    def next_book
      return @next_book if defined? @next_book
      @next_book = Book.find_by_id(id + 1)
    end
  end
end
