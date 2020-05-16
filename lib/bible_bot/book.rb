module BibleBot
  class Book
    attr_reader :id
    attr_reader :name
    attr_reader :abbreviation
    attr_reader :regex
    attr_reader :chapters
    attr_reader :testament

    def self.find_by_name(name)
      return nil if name.nil? || name.strip == ""

      Bible.books.find { |book| name.match(Regexp.new('\b'+book.regex, Regexp::IGNORECASE)) }
    end

    def self.find_by_id(id)
      Bible.books.find { |book| book.id == id }
    end

    def initialize(id: "", name: "", abbreviation: "", regex: "", chapters: [] , testament: "")
      @id = id
      @name = name
      @abbreviation = abbreviation
      @regex = regex
      @chapters = chapters
      @testament = testament
    end

    def formatted_name
      if name == 'Psalms'
        return 'Psalm'
      elsif name == 'Revelation of Jesus Christ'
        return 'Revelation'
      else
        return name
      end
    end

    # Single chapter book like Jude
    def single_chapter?
      chapters.length == 1
    end

    def next_book
      return @next_book if defined? @next_book
      @next_book = Book.find_by_id(id + 1)
    end
  end
end
