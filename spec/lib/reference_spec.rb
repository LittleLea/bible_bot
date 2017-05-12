require 'spec_helper'

describe BibleBot::Reference do

  it "Properly formats output" do
    reference = BibleBot::Reference.new( book: BibleBot::Bible.books.first, chapter_number: 1, verse_number: 1, end_chapter_number: nil, end_verse_number: nil )
    
    expect( reference.formatted ).to eq "Genesis 1:1"
  end
end