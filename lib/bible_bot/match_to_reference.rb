class MatchToReference
  attr_reader :match, :b1, :c1, :v1, :b2, :c2, :v2

  def initialize(match)
    @match = match
    @b1 = match[:BookTitle]
    @c1 = match[:ChapterNumber]
    @v1 = match[:VerseNumber]

    @b2 = match[:BookTitleSecond]
    @c2 = match[:EndChapterNumber]
    @v2 = match[:EndVerseNumber]
  end

  def reference
    Reference.new(
      start_verse: Verse.new(book: start_book, chapter_number: start_chapter.to_i, verse_number: start_verse.to_i),
      end_verse: Verse.new(book: end_book, chapter_number: end_chapter.to_i, verse_number: end_verse.to_i),
    )
  end

  def start_book
    Book.find_by_name(@b1)
  end

  def end_book
    Book.find_by_name(@b2) || start_book
  end

  def start_chapter
    return 1 if start_book.single_chapter?
    c1
  end

  def start_verse
    v1 || (start_book.single_chapter? ? c1 : 1)
  end

  def end_chapter
    return start_chapter if single_verse_ref?
    return 1 if end_book.single_chapter?
    return c1 if !b2 && !v2 && v1  # Ex: Genesis 1:1-2
    c2 || c1
  end

  def end_verse
    return start_verse if single_verse_ref?
    v2 || ((v1 && !b2) ? (c2 || v1) : end_book.chapters[end_chapter.to_i - 1])
  end

  private

  def single_verse_ref?
    !b2 && !c2 && !v2 &&
    (v1 || start_book.single_chapter?) # Ex: Genesis 5:1 || Jude 5
  end
end
