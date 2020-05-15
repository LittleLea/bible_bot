module BibleBot
  class Book
    attr_accessor :id
    attr_accessor :name
    attr_accessor :abbreviation
    attr_accessor :regex
    attr_accessor :chapters
    attr_accessor :testament

    def initialize( id: "", name: "", abbreviation: "", regex: "", chapters: [] , testament: "" )
      self.id = id
      self.name = name
      self.abbreviation = abbreviation
      self.regex = regex
      self.chapters = chapters
      self.testament = testament
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

    def self.find_by_name(name)
      Bible.books.find { |book| name.match(Regexp.new('\b'+book.regex, Regexp::IGNORECASE)) }
    end

    def self.find_by_id(id)
      Bible.books.find { |book| book.id == id }
    end
  end
end
