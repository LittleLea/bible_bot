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
