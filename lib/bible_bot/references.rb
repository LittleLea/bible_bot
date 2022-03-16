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

    # All if the string ids of the verses in the references.
    #
    # @return [String]
    # @example
    #  BibleBot::Reference.parse('John 3:16-18, Mark 1:3-4').string_ids
    #  #=> ['john-003-016', 'john-003-017', 'john-003-018', 'mark-001-003', 'mark-001-004']
    def string_ids
      flat_map { |r| r.verses.map(&:string_id) }
    end

  end
end
