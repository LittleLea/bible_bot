require 'spec_helper'

describe BibleBot::Reference do

  it "Properly formats output" do
    reference = BibleBot::Reference.new( book: BibleBot::Bible.books.first, chapter_number: 1, verse_number: 1, end_chapter_number: nil, end_verse_number: nil )
    
    expect( reference.formatted ).to eq "Genesis 1:1"
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