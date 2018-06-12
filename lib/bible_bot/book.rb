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

  end
end
