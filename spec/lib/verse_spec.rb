require 'spec_helper'

describe Verse do
  describe 'self.from_id' do
    [
      [19_105_001, "Psalm 105:1"],
      [1_001_001, "Genesis 1:1"],
      [66_022_021, "Revelation 22:21"],
    ].each do |integer, expected_reference|
      context "id=integer" do
        it "initializes verse #{expected_reference}" do
          expect(Verse.from_id(integer).formatted).to eq(expected_reference)
        end
      end
    end
  end

  describe 'valid?' do
    [
      { verse_id: 1_050_001, expect_valid: true },
      { verse_id: 5_001_046, expect_valid: true },
      { verse_id: 1_051_001, expect_valid: false },
      { verse_id: 5_001_047, expect_valid: false },
    ].each do |t|
      context "verse_id=#{t[:verse_id]}" do
        if t[:expect_valid]
          it "returns true for valid verse" do
            expect(Verse.from_id(t[:verse_id]).send(:valid?)).to be true
          end
        else
          it "raises InvalidVerse error on intialize" do
            expect{ Verse.from_id(t[:verse_id]) }.to raise_error InvalidVerseError
          end
        end
      end
    end
  end
end
