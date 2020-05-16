module BibleBot
  class Parser

    # Extract an array of scripture references from a block of text
    def extract(text, ignore_errors: false)
      references = []
      regex_matches(text).each do |match|
        begin
          references << normalize_reference(match)
        rescue BibleBotError => e
          raise e unless ignore_errors
          next
        end
      end

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

    def normalize_reference(match)
      start_book = Book.find_by_name(match[:BookTitle])

      # SPECIAL CASE FOR BOOKS WITH ONE CHAPTER:
      # If there is only one chapter in this book, set the chapter to one and
      # treat the incoming chapter argument as though it were the verse.
      # This normalizes references such as:
      # Jude 2 and Jude 2-4
      if start_book.single_chapter?
        start_chapter = 1
        start_verse = (match[:VerseNumber] || match[:ChapterNumber])&.to_i
      else
        start_chapter = match[:ChapterNumber]&.to_i
        start_verse = match[:VerseNumber]&.to_i
      end

      end_book = Book.find_by_name(match[:BookTitleSecond]) || start_book
      if end_book.single_chapter?
        end_chapter = 1
        end_verse = (match[:EndVerseNumber] || match[:EndChapterNumber] || start_verse)&.to_i
      else
        end_chapter = (match[:EndChapterNumber] || start_chapter)&.to_i
        end_verse = (match[:EndVerseNumber] || start_verse)&.to_i
      end

      # Support references with or without verse or chapters.
      # Ex:
      #   "Genesis 1" should match the whole chapter
      #   "Genesis" should match the whole book
      start_chapter ||= 1
      start_verse ||= 1
      end_chapter ||= end_book.chapters.length
      end_verse ||= end_book.chapters[end_chapter - 1]

      Reference.new(
        start_verse: Verse.new(book: start_book, chapter_number: start_chapter, verse_number: start_verse),
        end_verse: Verse.new(book: end_book, chapter_number: end_chapter, verse_number: end_verse),
      )
    end

    private

    def regex_matches(text)
      Array.new.tap { |matches| text.scan(Bible.new.scripture_re){ matches << $~ } }
    end
  end
end
