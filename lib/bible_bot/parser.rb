module BibleBot

  #From forgeapps/scripture_parser v0.0.1
  class Parser
    def extract(text)
      #Extract a list of tupled scripture references from a block of text
      references = []
      text.scan(Bible.new.scripture_re).each do |match|

        # Skip results where bookname is nil
        bookname = match[0]
        next if bookname == "" || bookname.nil?

        begin
          references << normalize_reference(*match)
          #rescue
          #next
        end
      end
      names = Bible.new.scripture_re.names
      names.delete("BookTitleSecond") #Cheap Hack to avoid having to
      # return references.collect do |match|
      #   Hash[names.zip(match)]
      # end

      return references
    end

    def is_valid_reference(bookname, chapter, verse = nil, end_chapter = nil, end_verse = nil)
      #Check to see if a scripture reference is valid
      begin
        return !normalize_reference(bookname, chapter, verse, nil, end_chapter, end_verse).nil?
      rescue
        return false
      end
    end

    def reference_to_string(bookname, chapter, verse = nil, end_chapter = nil, end_verse = nil)
      #Get a display friendly string from a scripture reference
      book = nil

      normalized = normalize_reference(bookname, chapter, verse, nil, end_chapter, end_verse)

      # if start and end chapters are the same
      if normalized[1] == normalized[3]
        book = Book.find_by_name(normalized[0])

        if book.chapters.length == 1 # single chapter book
          # If start and end verses are the same
          if normalized[2] == normalized[4]
            return "#{normalized[0]} #{normalized[2]}"
          else
            return "#{normalized[0]} #{normalized[2]}-#{normalized[4]}"
          end
        else # multichapter book
          # If the start verse is one and the end verse is the last verse in the chapter
          if normalized[2] == 1 and normalized[4] == book.chapters[normalized[1]-1]
            return "#{normalized[0]} #{normalized[1]}"
          # If start and end verses are the same
          elsif normalized[2] == normalized[4]
            return "#{normalized[0]} #{normalized[1]}:#{normalized[2]}"
          else
            return "#{normalized[0]} #{normalized[1]}:#{normalized[2]}-#{normalized[4]}"
          end
        end
      else # start and end chapters are different
        return "#{normalized[0]} #{normalized[1]}:#{normalized[2]}-#{normalized[3]}:#{normalized[4]}"
      end
    end

    def reference_range_to_verse_range(bookname, chapter, verse = nil, end_chapter = nil, end_verse = nil)
      normalized = normalize_reference(bookname, chapter, verse, nil, end_chapter, end_verse)
      book = Book.find_by_name(normalized[0])

      if chapter == 1
        verse_count_before_starting_chapter = 0
      else
        verse_count_before_starting_chapter = book.chapters[0..chapter-2].inject(:+)
      end

      verse_range_start = verse_count_before_starting_chapter + verse

      if end_chapter == 1
        verse_count_before_end_chapter = 0
      else
        verse_count_before_end_chapter = book.chapters[0..end_chapter-2].inject(:+)
      end

      verse_range_end = verse_count_before_end_chapter + end_verse
      return [book.name, verse_range_start, verse_range_end]
    end

    def verse_range_to_reference_range(bookname, verse_range_start, verse_range_end = nil)
      #s.verse_range_to_reference_range("Genesis", 32, 51)
      book = Book.find_by_name(bookname)

      start_chapter = 1
      start_verse = 1
      book.chapters.each do |verse_count|
        if verse_range_start > verse_count
          start_chapter += 1
          verse_range_start -= verse_count
          if verse_range_start == 0
            start_verse = verse_count
            break
          end
        else
          start_verse = verse_range_start
          break
        end
      end

      if verse_range_end.nil?
        end_chapter = nil
        end_verse = nil
      else
        end_chapter = 1
        end_verse = 1
        book.chapters.each do |verse_count|
          if verse_range_end > verse_count
            end_chapter += 1
            verse_range_end -= verse_count
            if verse_range_start == 0
              end_verse = verse_count
              break
            end
          else
            end_verse = verse_range_end
            break
          end
        end
      end

      return normalize_reference(bookname, start_chapter, start_verse, nil, end_chapter, end_verse)
    end

    def normalize_reference(bookname, chapter, verse = nil, second_bookname = nil, end_chapter = nil, end_verse = nil)
      # Get a complete five value tuple scripture reference with full book name
      # from partial data
      book = Book.find_by_name(bookname)
      if !second_bookname.nil? && !second_bookname.strip == ""
        second_book = Book.find_by_name(second_bookname)
        raise InvalidReferenceError if second_book != book
      end

      # SPECIAL CASE FOR BOOKS WITH ONE CHAPTER:
      # If there is only one chapter in this book, set the chapter to one and
      # treat the incoming chapter argument as though it were the verse.
      # This normalizes references such as:
      # Jude 2 and Jude 2-4
      if book.chapters.length == 1
        if verse.nil? && end_chapter.nil?
          verse = chapter
          chapter = 1
        end
      else
        # This is not a single chapter book.
        # If a start verse was NOT provided, but an end_verse was- we have a
        # reference such as John 3-4 which we want to parse as John 3:1 - John 4:54
        if verse.nil? && end_verse
          verse = 1
          end_chapter = end_verse
          end_verse = book.chapters[end_chapter.to_i - 1]
        end
      end

      # Convert to integers or leave as Nil
      chapter = chapter ? chapter.to_i : nil
      verse =  verse ? verse.to_i : nil
      end_chapter = end_chapter ? end_chapter.to_i : chapter
      end_verse = end_verse ? end_verse.to_i : nil

      if (book.nil? \
         || (chapter.nil? || chapter < 1 || chapter > book.chapters.length) \
         || (verse && (verse < 1 or verse > book.chapters[chapter-1])) \
         || (end_chapter \
           && (end_chapter < 1 || end_chapter < chapter ||  end_chapter > book.chapters.length)) \
         || (end_verse \
           && (end_verse < 1 \
           || (end_chapter && end_verse > book.chapters[end_chapter-1]) \
           || (chapter == end_chapter and end_verse < verse) ) ) )

        raise InvalidReferenceError
      end

      if verse.nil?
        # return [book.name, chapter, 1, chapter, book.chapters[chapter-1]]
        return Reference.new( book: book, chapter_number: chapter, verse_number: 1, end_chapter_number: chapter, end_verse_number: book.chapters[chapter-1])
      end
      if end_verse.nil?
        if end_chapter && end_chapter != chapter
          end_verse = book.chapters[end_chapter-1]
        else
          end_verse = verse
        end
      end
      if end_chapter.nil?
        end_chapter = chapter
      end
      # return [book.name, chapter, verse, end_chapter, end_verse]
      return Reference.new( book: book, chapter_number: chapter, verse_number: verse, end_chapter_number: end_chapter, end_verse_number: end_verse)
    end
  end

end
