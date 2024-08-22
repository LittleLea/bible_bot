# frozen_string_literal: true

module BibleBot
  # Represents one of the 66 books in the bible (Genesis - Revelation) or Apocryphal books.
  # You should never need to initialize a Book, they are initialized in {Bible}.
  class Book
    NULL = Object.new.freeze
    private_constant :NULL

    TESTAMENTS = {
      apocrypha: 'Apocrypha',
      new_testament: 'New Testament',
      old_testament: 'Old Testament',
    }.freeze
    private_constant :TESTAMENTS

    attr_reader :id # @return [Integer]
    attr_reader :name # @return [String]
    attr_reader :abbreviation # @return [String]
    attr_reader :dbl_code # @return [String]
    attr_reader :regex # @return [String]
    attr_reader :regex_matcher # @return [Regexp]
    attr_reader :chapters # @return [Array<Integer>]
    attr_reader :testament # @return [Symbol]
    attr_reader :testament_name # @return [String]

    # Uses the same Regex pattern to match as we use in {Reference.parse}.
    # So this supports the same book name abbreviations.
    #
    # @param name [String]
    # @return [Book]
    # @example
    #   Book.find_by_name("Genesis")
    def self.find_by_name(name)
      return nil if name.nil? || name.strip == ""
      name = name.tr('’', "'")
      name = I18n.transliterate(name)

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

    def initialize(id:, name:, abbreviation:, dbl_code:, regex:, testament:, chapters: [])
      raise "Unknown testament: #{testament.inspect}" unless TESTAMENTS.key?(testament)

      @id = id
      @name = name
      @abbreviation = abbreviation
      @dbl_code = dbl_code
      @regex = regex
      @chapters = chapters
      @testament = testament
      @testament_name = TESTAMENTS[testament]
      @regex_matcher = Regexp.new('\b'+regex+'\b', Regexp::IGNORECASE).freeze
      @chapter_string_ids = nil
      @reference = nil
      @first_verse = nil
      @last_verse = nil
      @next_book = NULL
      @apocryphal = testament == :apocrypha
    end

    # Whether or not the book is one of the original 66
    # @return [Boolean]
    def apocryphal?
      @apocryphal
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

    # @return [Array<String>]
    # @example
    #   BibleBot::Book.find_by_id(39).chapter_string_ids
    #   #=> ['malachi-001', 'malachi-002', 'malachi-003', 'malachi-004']
    def chapter_string_ids
      @chapter_string_ids ||= References.new([reference]).chapter_string_ids
    end

    # @return [Array<Integer>]
    def verse_ids
      @verse_ids ||= chapters
      .flat_map.with_index do |verse_count, i|
        chapter_number = i + 1

        1.upto(verse_count).map do |verse_number|
          verse_id(chapter_number:, verse_number:)
        end
      end
    end

    # @return [Verse]
    def start_verse
      @first_verse ||= Verse.from_id(
        verse_id(chapter_number: 1, verse_number: 1)
      )
    end

    # @return [Verse]
    def end_verse
      @last_verse ||= Verse.from_id(
        verse_id(chapter_number: chapters.length, verse_number: chapters.last)
      )
    end

    # @return [Book, nil]
    def next_book
      return @next_book unless @next_book == NULL
      @next_book = Book.find_by_id(id + 1)
    end

    private
    def verse_id(chapter_number:, verse_number:)
      Verse.integer_id(book_id: id, chapter_number:, verse_number:)
    end
  end
end
