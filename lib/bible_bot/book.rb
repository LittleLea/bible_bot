module BibleBot
  # Represents one of the 66 books in the bible (Genesis - Revelation).
  # You should never need to initialize a Book, they are initialized in {Bible}.
  class Book
    NULL = Object.new.freeze
    private_constant :NULL

    attr_reader :id # @return [Integer]
    attr_reader :name # @return [String]
    attr_reader :abbreviation # @return [String]
    attr_reader :dbl_code # @return [String]
    attr_reader :regex # @return [String]
    attr_reader :regex_matcher # @return [Regexp]
    attr_reader :chapters # @return [Array<Integer>]
    attr_reader :testament # @return [String]

    # Uses the same Regex pattern to match as we use in {Reference.parse}.
    # So this supports the same book name abbreviations.
    #
    # @param name [String]
    # @return [Book]
    # @example
    #   Book.find_by_name("Genesis")
    def self.find_by_name(name)
      return nil if name.nil? || name.strip == ""

      Bible.books.detect { |book| book.name.casecmp?(name) || book.regex_matcher.match?(name) }
    end

    # Find by the DBL Code defined in {Bible}.
    #
    # @param code [String]
    # @return [Book]
    def self.find_by_dbl_code(code)
      return nil if code.nil? || code.empty?

      Bible.books.detect { |book| book.dbl_code == code }
    end

    # Find by the Book ID defined in {Bible}.
    #
    # @param id [Integer]
    # @return [Book]
    def self.find_by_id(id)
      Bible.books.find { |book| book.id == id }
    end

    def initialize(id:, name:, abbreviation:, dbl_code:, regex:, chapters: [] , testament:)
      @id = id
      @name = name
      @abbreviation = abbreviation
      @dbl_code = dbl_code
      @regex = regex
      @chapters = chapters
      @testament = testament
      @regex_matcher = Regexp.new('\b'+regex+'\b', Regexp::IGNORECASE).freeze
      @reference = nil
      @first_verse = nil
      @last_verse = nil
      @next_book = NULL
    end

    # @return [String]
    def formatted_name
      case name
      when 'Psalms' then 'Psalm'
      else name
      end
    end

    # @return String
    # @example
    #  BibleBot::Book.find_by_id(53).string_id
    #  #=> '2_thessalonians'
    def string_id
      name.downcase.gsub(' ', '_')
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
      return @next_book unless @next_book == NULL
      @next_book = Book.find_by_id(id + 1)
    end
  end
end
