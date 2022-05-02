require 'spec_helper'

describe BibleBot::Book do

  describe "find_by_id" do
    [
      {id: 1, expected: "Genesis"},
      {id: 19, expected: "Psalms"},
      {id: 66, expected: "Revelation"},
      {id: 67, expected: nil},
    ].each do |t|
      context "id=#{t[:id]}" do
        it "It finds #{t[:expected]}" do
          book = described_class.find_by_id(t[:id])

          if t[:expected] == nil
            expect(book).to be nil
          else
            expect(book).to be_a BibleBot::Book
            expect(book.name).to eq t[:expected]
          end
        end
      end
    end
  end

  describe "find_by_name" do
    [
      {name: "genesis", expected: "Genesis"},
      {name: "psalm", expected: "Psalms"},
      {name: "rev", expected: "Revelation"},
      {name: "nothing", expected: nil},
    ].each do |t|
      context "name=#{t[:name]}" do
        it "It finds #{t[:expected]}" do
          book = described_class.find_by_name(t[:name])

          if t[:expected] == nil
            expect(book).to be nil
          else
            expect(book).to be_a BibleBot::Book
            expect(book.name).to eq t[:expected]
          end
        end
      end
    end
  end

  describe "string_id" do
    it "returns the book's string id" do
      book = BibleBot::Book.find_by_id(53)
      expect(book.string_id).to eq('2_thessalonians')
    end
  end

  describe "reference" do
    let(:book) { BibleBot::Book.find_by_name("1 John") }

    it "returns reference" do
      expect(book.reference.inspect).to include(start_verse: "1 John 1:1", end_verse: "1 John 5:21")
    end
  end
end
