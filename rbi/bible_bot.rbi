# typed: strict

module BibleBot
  class << self

    sig { returns(include: T::Boolean) }
    def include_apocryphal_content?; end

    sig { params(include: T::Boolean).void }
    def include_apocryphal_content=(include); end
  end
end

class BibleBot::Bible
  class << self
    sig { returns(T::Array[BibleBot::Book]) }
    def books; end
  end
end

class BibleBot::Book
  class << self
    sig { params(name: T.nilable(String)).returns(T.nilable(BibleBot::Book)) }
    def find_by_name(name); end

    sig { params(code: T.nilable(String)).returns(T.nilable(BibleBot::Book)) }
    def find_by_code(code); end

    sig { params(id: T.nilable(Integer)).returns(T.nilable(BibleBot::Book)) }
    def find_by_id(id); end
  end

  sig { returns(Integer) }
  def id; end

  sig { returns(String) }
  def name; end

  sig { returns(String) }
  def abbreviation; end

  sig { returns(String) }
  def dbl_code; end

  sig { returns(T::Array[Integer]) }
  def chapters; end

  sig { returns(Symbol) }
  def testament; end

  sig { returns(String) }
  def testament_name; end

  sig { returns(T::Boolean) }
  def apocryphal?; end

  sig { returns(String) }
  def formatted_name; end

  sig { returns(String) }
  def string_id; end

  sig { returns(BibleBot::Reference) }
  def reference; end

  sig { returns(T::Array[String]) }
  def chapter_string_ids; end

  sig { returns(T::Array[Integer]) }
  def verse_ids; end

  sig { returns(BibleBot::Verse) }
  def start_verse; end

  sig { returns(BibleBot::Verse) }
  def end_verse; end

  sig { returns(T.nilable(BibleBot::Book)) }
  def next_book; end
end

class BibleBot::Verse
  include Comparable

  class << self
    sig { params(id: T.nilable(T.any(Integer, String))).returns(T.nilable(BibleBot::Verse)) }
    def from_id(id); end

    sig { params(book_id: Integer, chapter_number: Integer, verse_number: Integer).returns(Integer) }
    def integer_id(book_id:, chapter_number:, verse_number:); end
  end

  sig { returns(BibleBot::Book) }
  def book; end

  sig { returns(Integer) }
  def chapter_number; end

  sig { returns(Integer) }
  def verse_number; end

  sig { returns(Integer) }
  def id; end

  sig { returns(String) }
  def string_id; end

  sig { params(other: BibleBot::Verse).returns(Integer) }
  def <=>(other); end

  sig { params(include_book: T::Boolean, include_chapter: T::Boolean, include_verse: T::Boolean).returns(String) }
  def formatted(include_book: true, include_chapter: true, include_verse: true); end

  sig { returns(T.nilable(BibleBot::Verse)) }
  def next_verse; end

  sig { returns(T::Boolean) }
  def last_verse_in_chapter?; end

  sig { returns(T::Boolean) }
  def last_chapter_in_book?; end

  sig { returns(T::Boolean) }
  def valid?; end

  sig { void }
  def validate!; end
end

class BibleBot::Reference
  class << self
    sig { params(start_verse_id: Integer, end_verse_id: T.nilable(Integer)).returns(BibleBot::Reference) }
    def from_verse_ids(start_verse_id, end_verse_id = nil); end

    sig { params(text: T.nilable(String), validate: T::Boolean).returns(BibleBot::References) }
    def parse(text, validate: false); end

    sig { params(text: T.nilable(String)).returns(T.nilable(String)) }
    def normalize(text); end

    sig { params(text: T.nilable(String)).returns(T::Array[String]) }
    def normalize_by_chapter(text); end
  end

  sig { returns(T::Verse) }
  def start_verse; end

  sig { returns(T::Verse) }
  def end_verse; end

  sig { returns(T::Boolean) }
  def contains_apocrypha?; end

  sig { returns(String) }
  def formatted; end

  sig { returns(T::Boolean) }
  def same_start_and_end_book?; end

  sig { returns(T::Boolean) }
  def same_start_and_end_chapter?; end

  sig { returns(T::Boolean) }
  def full_chapters?; end

  sig { params(verse: BibleBot::Verse).returns(T::Boolean) }
  def includes_verse?(verse); end

  sig { params(other: BibleBot::Reference).returns(T::Boolean) }
  def intersects_reference?(other); end

  sig { returns(T::Array[BibleBot::Verse]) }
  def verses; end

  sig { returns(T::Boolean) }
  def valid?; end

  sig { void }
  def validate!; end
end

class BibleBot::References
  include Enumerable
  extend T::Generic
  Elem = type_member(:out) { { fixed: BibleBot::Reference } }

  sig { returns(T::Array[Integer]) }
  def ids; end

  sig { returns(T.nilable(String)) }
  def formatted; end

  sig { returns(T::Boolean) }
  def contains_apocrypha?; end

  sig { returns(BibleBot::References) }
  def chapters; end

  sig { returns(T::Array[String]) }
  def string_ids; end

  sig { returns(T::Boolean) }
  def single_full_chapter?; end

  sig { returns(T::Boolean) }
  def single_chapter?; end

  sig { returns(T::Boolean) }
  def single_book?; end
  
  sig { returns(T::Array[String]) }
  def chapter_string_ids; end
end
