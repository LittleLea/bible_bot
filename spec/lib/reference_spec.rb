require 'spec_helper'

describe BibleBot::Reference do

  [
    ["Genesis 1:1", "Genesis 1:1"],
    ["Genesis 1:1-30", "Genesis 1:1-30"],
    ["Genesis 1:1-31", "Genesis 1"], # Leaves out verses when range includes the entire chapter
    ["Genesis 1:1-2:4", "Genesis 1:1-2:4"],
    ["Genesis 1:1-2:25", "Genesis 1-2"],
    ["Genesis 2:3-3:3", "Genesis 2:3-3:3"],
    ["Jude 1:1-1:6", "Jude 1-6"],
    ["something Genesis 1:1", "Genesis 1:1"],
    ["something Exodus 1:1", "Exodus 1:1"],
    ["something Leviticus 1:1", "Leviticus 1:1"],
    ["something Numbers 1:1", "Numbers 1:1"],
    ["something Deuteronomy 1:1", "Deuteronomy 1:1"],
    ["something Joshua 1:1", "Joshua 1:1"],
    ["something Judges 1:1", "Judges 1:1"],
    ["something Ruth 1:1", "Ruth 1:1"],
    ["something 1 Samuel 1:1", "1 Samuel 1:1"],
    ["something 2 Samuel 1:1", "2 Samuel 1:1"],
    ["something 1 Kings 1:1", "1 Kings 1:1"],
    ["something 2 Kings 1:1", "2 Kings 1:1"],
    ["something 1 Chronicles 1:1", "1 Chronicles 1:1"],
    ["something 2 Chronicles 1:1", "2 Chronicles 1:1"],
    ["something Ezra 1:1", "Ezra 1:1"],
    ["something Nehemiah 1:1", "Nehemiah 1:1"],
    ["something Esther 1:1", "Esther 1:1"],
    ["something Job 1:1", "Job 1:1"],
    ["something Psalms 1:1", "Psalm 1:1"],
    ["something Proverbs 1:1", "Proverbs 1:1"],
    ["something Ecclesiastes 1:1", "Ecclesiastes 1:1"],
    ["something Song of Solomon 1:1", "Song of Solomon 1:1"],
    ["something Isaiah 1:1", "Isaiah 1:1"],
    ["something Jeremiah 1:1", "Jeremiah 1:1"],
    ["something Lamentations 1:1", "Lamentations 1:1"],
    ["something Ezekiel 1:1", "Ezekiel 1:1"],
    ["something Daniel 1:1", "Daniel 1:1"],
    ["something Hosea 1:1", "Hosea 1:1"],
    ["something Joel 1:1", "Joel 1:1"],
    ["something Amos 1:1", "Amos 1:1"],
    ["something Obadiah 1:1", "Obadiah 1"],
    ["something Jonah 1:1", "Jonah 1:1"],
    ["something Micah 1:1", "Micah 1:1"],
    ["something Nahum 1:1", "Nahum 1:1"],
    ["something Habakkuk 1:1", "Habakkuk 1:1"],
    ["something Zephaniah 1:1", "Zephaniah 1:1"],
    ["something Haggai 1:1", "Haggai 1:1"],
    ["something Zechariah 1:1", "Zechariah 1:1"],
    ["something Malachi 1:1", "Malachi 1:1"],
    ["something Matthew 1:1", "Matthew 1:1"],
    ["something Mark 1:1", "Mark 1:1"],
    ["something Luke 1:1", "Luke 1:1"],
    ["something John 1:1", "John 1:1"],
    ["something Acts 1:1", "Acts 1:1"],
    ["something Romans 1:1", "Romans 1:1"],
    ["something 1 Corinthians 1:1", "1 Corinthians 1:1"],
    ["something 2 Corinthians 1:1", "2 Corinthians 1:1"],
    ["something Galatians 1:1", "Galatians 1:1"],
    ["something Ephesians 1:1", "Ephesians 1:1"],
    ["something Philippians 1:1", "Philippians 1:1"],
    ["something Colossians 1:1", "Colossians 1:1"],
    ["something 1 Thessalonians 1:1", "1 Thessalonians 1:1"],
    ["something 2 Thessalonians 1:1", "2 Thessalonians 1:1"],
    ["something 1 Timothy 1:1", "1 Timothy 1:1"],
    ["something 2 Timothy 1:1", "2 Timothy 1:1"],
    ["something Titus 1:1", "Titus 1:1"],
    ["something Philemon 1:1", "Philemon 1"],
    ["something Hebrews 1:1", "Hebrews 1:1"],
    ["something James 1:1", "James 1:1"],
    ["something 1 Peter 1:1", "1 Peter 1:1"],
    ["something 2 Peter 1:1", "2 Peter 1:1"],
    ["something 1 John 1:1", "1 John 1:1"],
    ["something 2 John 1:1", "2 John 1"],
    ["something 3 John 1:1", "3 John 1"],
    ["something Jude 1:1", "Jude 1"],
    ["something Revelation 1:1", "Revelation 1:1"],
  ].each do |text, expected_formated_value|
    describe text do
      it "Properly formats output" do
        expect( BibleBot::Parser.new.extract(text).first.formatted ).to eq expected_formated_value
      end
    end
  end

  it "Properly calculates the number of verses" do
    reference = BibleBot::Reference.new( book: BibleBot::Bible.books.first, chapter_number: 1, verse_number: 1, end_chapter_number: nil, end_verse_number: nil )
    expect(reference.verses.size).to eq 1


    reference = BibleBot::Reference.new( book: BibleBot::Bible.books.first, chapter_number: 1, verse_number: 1, end_chapter_number: 1, end_verse_number: 5 )
    expect(reference.verses.size).to eq 5

    reference = BibleBot::Reference.new( book: BibleBot::Bible.books.first, chapter_number: 1, verse_number: 1, end_chapter_number: 2, end_verse_number: 5 )
    expect(reference.verses.size).to eq 36

    reference = BibleBot::Reference.new( book: BibleBot::Bible.books.first, chapter_number: 1, verse_number: 1, end_chapter_number: 2, end_verse_number: nil )
    expect(reference.verses.size).to eq 56

  end
end
