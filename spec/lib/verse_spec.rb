require 'spec_helper'

describe Verse do
  describe 'self.from_id' do
    [
      [19_105_001, "Psalm 105:1"],
      [1_001_001, "Genesis 1:1"],
      [66_022_021, "Revelation 22:21"],
    ].each do |id, expected_reference|
      context "id=integer" do
        it "initializes verse #{expected_reference}" do
          expect(Verse.from_id(id).formatted).to eq(expected_reference)
        end
      end
    end

    [
      ["psalms-105-001", "Psalm 105:1"],
      ["genesis-001-001", "Genesis 1:1"],
      ["revelation-022-021", "Revelation 22:21"],
    ].each do |id, expected_reference|
      context "id=string" do
        it "initializes verse #{expected_reference}" do
          expect(Verse.from_id(id).formatted).to eq(expected_reference)
        end
      end
    end
  end

  describe "id" do
    let(:id) { 10_020_004 }
    it "returns back the verse ID" do
      expect(Verse.from_id(id).id).to eq(id)
    end
  end

  describe "string_id" do
    let(:id) { 10_020_004 }
    let(:string_id) { "2_samuel-020-004" }
    it "returns back the verse ID" do
      expect(Verse.from_id(id).string_id).to eq(string_id)
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
