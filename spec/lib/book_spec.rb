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
      {name: "gènesis", expected: "Genesis"},
      {name: "psalm", expected: "Psalms"},
      {name: "rev", expected: "Revelation"},
      {name: "I’m Feeling", expected: nil},
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

  describe "find_by_dbl_code" do
    [
      {name: "GEN", expected: "Genesis"},
      {name: "PSA", expected: "Psalms"},
      {name: "REV", expected: "Revelation"},
      {name: nil, expected: nil},
    ].each do |t|
      context "name=#{t[:name]}" do
        it "It finds #{t[:expected]}" do
          book = described_class.find_by_dbl_code(t[:name])

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

  describe "verse_ids" do
    it "returns an array of verse ids" do
      book = BibleBot::Book.find_by_id(1)

      expect(book.verse_ids.first).to eq(1001001)
      expect(book.verse_ids.last).to eq(1050026)
      expect(book.verse_ids.size).to eq(1533)
    end
  end

  describe "chapter_string_ids" do
    it "returns the array of chapter ids" do
      book = BibleBot::Book.find_by_id(39)
      expect(book.chapter_string_ids).to eq([
        "malachi-001", "malachi-002", "malachi-003", "malachi-004"
      ])
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

  describe '#testament_name' do
    subject { book.testament_name }

    let(:book) do
      BibleBot::Book.new(
        id: 999,
        name: 'Foo',
        abbreviation: 'Foo',
        dbl_code: 'FOO',
        regex: 'foo',
        testament:
      )
    end

    context 'when old testament' do
      let(:testament) { :old_testament }
      it { is_expected.to eq('Old Testament') }
    end

    context 'when new testament' do
      let(:testament) { :new_testament }
      it { is_expected.to eq('New Testament') }
    end

    context 'when apocryphal' do
      let(:testament) { :apocrypha }
      it { is_expected.to eq('Apocrypha') }
    end
  end

  describe "apocryphal?" do
    subject { book.apocryphal? }

    let(:book) do
      BibleBot::Book.new(
        id: 999,
        name: 'Foo',
        abbreviation: 'Foo',
        dbl_code: 'FOO',
        regex: 'foo',
        testament:
      )
    end

    context 'when old testament' do
      let(:testament) { :old_testament }
      it { is_expected.to eq(false) }
    end

    context 'when new testament' do
      let(:testament) { :new_testament }
      it { is_expected.to eq(false) }
    end

    context 'when apocryphal' do
      let(:testament) { :apocrypha }
      it { is_expected.to eq(true) }
    end
  end
end
