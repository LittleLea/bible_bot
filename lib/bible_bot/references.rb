require 'delegate'

module BibleBot
  # References represent a collection of Reference objects. It wraps an Array, to provide some
  # convenience methods for commonly performed actions.
  class References < DelegateClass(Array)

    # All if the integer ids of the verses in the references.
    #
    # @return [Integer]
    # @example
    #  BibleBot::Reference.parse('John 3:16-18, Mark 1:3-4').ids
    #  #=> [43003016, 43003017, 43003018, 41001003, 41001004]
    def ids
      flat_map { |r| r.verses.map(&:id) }
    end

    # Returns a formatted string of the references, or nil if there are no references.
    #
    # @return [String, nil]
    # @example
    #   BibleBot::Reference.parse('Gen 1-2, Matt 1-3').formatted
    #   #=> 'Genesis 1-2; Matthew 1-3'
    #
    #   BibleBot::Reference.parse('Gen 100-200, Matt 50-80').formatted
    #   #=> nil
    def formatted
      map(&:formatted).join('; ') unless empty?
    end

    # Returns a boolean if any of the references contain an apocryphal book
    #
    # @return [Boolean]
    #
    # @example
    #   BibleBot::Reference.parse('Gen 1-2, Matt 1-3').contains_apocrypha?
    #   #=> false
    #
    #   BibleBot::Reference.parse('Gen 1-2, Tob 1; Matt 1-3').contains_apocrypha?
    #   #=> true
    def contains_apocrypha?
      any?(&:contains_apocrypha?)
    end

    # Returns an array of BibleBot::Reference objects, where each reference contains
    # the verses of just 1 chapter.
    #
    # @return [BibleBot::References]
    def chapters
      strings = flat_map do |reference|
        verses = reference.verses + [nil]

        new_references = []
        start = nil
        previous = nil

        verses.each do |verse|
          start ||= verse

          if verse.nil? || start.book != verse.book || start.chapter_number != verse.chapter_number
            reference = Reference.new(start_verse: start, end_verse: previous)
            new_references << reference
            start = verse
          end

          previous = verse
        end

        next new_references
      end

      self.class.new(strings)
    end

    # All if the string ids of the verses in the references.
    #
    # @return [String]
    # @example
    #  BibleBot::Reference.parse('John 3:16-18, Mark 1:3-4').string_ids
    #  #=> ['john-003-016', 'john-003-017', 'john-003-018', 'mark-001-003', 'mark-001-004']
    def string_ids
      flat_map { |r| r.verses.map(&:string_id) }
    end

    # Is the reference 1 bible chapter, such as "Matthew 1" or "John 3"?
    #
    # @return [Boolean]
    # @example
    #  BibleBot::Reference.parse('Matthew 1').single_full_chapter?
    #  #=> true
    def single_full_chapter?
      single_chapter? && first.full_chapters?
    end

    # Does the scripture span more than 1 bible chapter?
    #
    # @return [Boolean]
    # @example
    #  BibleBot::Reference.parse('Matthew 1:4-9').single_chapter?
    #  #=> true
    #
    #  BibleBot::Reference.parse('Matthew 1:3-2:1').single_chapter?
    #  #=> false
    def single_chapter?
      length == 1 && first.same_start_and_end_chapter?
    end

    # @return [Array<String>]
    # @example
    #   BibleBot::Reference.parse('Matthew 1-2, John 3-4').chapter_string_ids
    #   #=> ['matthew-001', 'matthew-002', 'john-003', 'john-004']
    def chapter_string_ids
      chapters = []
      each do |reference|
        reference.verses.each do |verse|
          chapters << [verse.book, verse.chapter_number]
        end
      end

      chapters.uniq.map do |book, chapter|
        "#{book.string_id}-#{chapter.to_s.rjust(3, '0')}"
      end
    end

  end
end
