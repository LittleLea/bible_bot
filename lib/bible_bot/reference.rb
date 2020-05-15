module BibleBot
  class Reference

    attr_accessor :book
    attr_accessor :chapter_number
    attr_accessor :verse_number
    attr_accessor :end_chapter_number
    attr_accessor :end_verse_number

    def self.from_verse_id(verse_id)
      parts = verse_id.split( '-' )

      book_name      = parts[0].gsub( '_', ' ' )
      chapter_number = parts[1].to_i
      verse_number   = parts[2].to_i

      book = BibleBot::Bible.books.select{ |b| b.name.downcase == book_name }.first

      raise BibleBot::InvalidVerseID if book.nil?

      return Reference.new( book: book, chapter_number: chapter_number, verse_number: verse_number )
    end


    def initialize( book: nil, chapter_number: nil, verse_number: nil, end_chapter_number: nil, end_verse_number: nil )
      self.book               = book
      self.chapter_number     = chapter_number
      self.verse_number       = verse_number
      self.end_chapter_number = end_chapter_number
      self.end_verse_number   = end_verse_number

      if end_chapter_number.nil?
        self.end_chapter_number = chapter_number
      end

      if end_verse_number.nil? && (self.chapter_number != self.end_chapter_number)
        self.end_verse_number = self.book.chapters[self.end_chapter_number - 1]
      elsif end_verse_number.nil?
        self.end_verse_number = self.verse_number
      end
    end

    def formatted(always_include_chapter: false)
      if same_start_and_end_chapter?
        if single_chapter_book? && !always_include_chapter
          if same_start_and_end_verse?
            return "#{book.formatted_name} #{verse_number}"
          else
            return "#{book.formatted_name} #{verse_number}-#{end_verse_number}"
          end
        else
          if full_chapters?
            return "#{book.formatted_name} #{chapter_number}"
          elsif same_start_and_end_verse?
            return "#{book.formatted_name} #{chapter_number}:#{verse_number}"
          else
            return "#{book.formatted_name} #{chapter_number}:#{verse_number}-#{end_verse_number}"
          end
        end
      else # start and end chapters are different
        if full_chapters?
          return "#{book.formatted_name} #{chapter_number}-#{end_chapter_number}"
        else
          return "#{book.formatted_name} #{chapter_number}:#{verse_number}-#{end_chapter_number}:#{end_verse_number}"
        end
      end
    end

    def same_start_and_end_chapter?
      chapter_number == end_chapter_number || end_chapter_number.nil?
    end

    def same_start_and_end_verse?
      verse_number == end_verse_number || end_verse_number.nil?
    end

    # Single chapter book like Jude
    def single_chapter_book?
      book.chapters.length == 1
    end

    # One or multiple full chapters
    def full_chapters?
      verse_number == 1 && end_verse_number == book.chapters[(end_chapter_number || chapter_number)-1]
    end

    def to_s
      "BibleBot::Reference — #{formatted}"
    end

    def verses
      verses = []

      (chapter_number..end_chapter_number).each do |c|
        # end verse is last verse unless c == end_chapter_number, in which case it's end_verse_number
        if c == chapter_number
          sv = verse_number
        else
          sv = 1
        end

        if c == end_chapter_number
          ev = end_verse_number
        else
          ev = book.chapters[c-1] # this is the number of verses in this chapter
        end

        (sv..ev).each do |v|
          verses.push( Verse.new( book: book, chapter_number: c, verse_number: v ) )
        end
      end

      verses
    end

  end
end
