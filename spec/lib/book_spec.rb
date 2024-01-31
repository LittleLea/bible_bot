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
      let(:testament) { 'Old' }
      it { is_expected.to eq(false) }
    end

    context 'when new testament' do
      let(:testament) { 'New' }
      it { is_expected.to eq(false) }
    end

    context 'when apocryphal' do
      let(:testament) { 'Apocrypha' }
      it { is_expected.to eq(true) }
    end
  end
end
