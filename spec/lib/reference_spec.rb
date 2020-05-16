require 'spec_helper'

describe BibleBot::Reference do
  describe "formatted" do
    [
      [1_001_001, nil, "Genesis 1:1"],
      [1_001_001, 1_001_001, "Genesis 1:1"],
      [1_001_001, 1_001_030, "Genesis 1:1-30"],
      [1_001_001, 1_001_031, "Genesis 1"], # Leaves out verses when range includes the entire chapter
      [1_001_001, 1_002_004, "Genesis 1:1-2:4"],
      [1_001_001, 1_002_025, "Genesis 1-2"],
      [1_002_003, 1_003_003, "Genesis 2:3-3:3"],
      [65_001_001, 65_001_006, "Jude 1-6"],
      [65_001_001, 65_001_025, "Jude"],
      [65_001_001, 66_001_015, "Jude 1-Revelation 1:15"],
      [1_050_001, 2_002_013, "Genesis 50:1-Exodus 2:13"],
      [1_001_001, 2_001_001, "Genesis 1:1-Exodus 1:1"],
    ].each do |start_verse_id, end_verse_id, expected_formated_value|
      describe "start_verse_id=#{start_verse_id} and end_verse_id=#{end_verse_id}" do
        subject { described_class.from_verse_ids(start_verse_id, end_verse_id).formatted }
        it { is_expected.to eq expected_formated_value }
      end
    end
  end

  describe "verses" do
    [
      [1_001_001, nil, 1],
      [1_001_001, 1_001_005, 5],
      [1_001_001, 1_002_005, 36],
      [1_001_001, 2_001_001, 1534],
    ].each do |start_verse_id, end_verse_id, expected_verse_count|
      describe "start_verse_id=#{start_verse_id} and end_verse_id=#{end_verse_id}" do
        subject { described_class.from_verse_ids(start_verse_id, end_verse_id).verses.count }
        it { is_expected.to eq expected_verse_count }
      end
    end
  end

  describe "include_verses?" do
    [
      [1_001_010, 2_001_001, 1_001_002, false],
      [1_001_010, 2_001_001, 1_001_010, true],
      [1_001_010, 2_001_001, 1_034_005, true],
      [1_001_010, 2_001_001, 2_001_001, true],
      [1_001_010, 2_001_001, 2_001_002, false],
      [1_001_010, 2_001_001, nil, false],
    ].each do |start_verse_id, end_verse_id, included_verse_id, expect_incuded|
      describe "start_verse_id=#{start_verse_id}, end_verse_id=#{end_verse_id}, included_verse_id=#{included_verse_id}" do
        let(:reference) { described_class.from_verse_ids(start_verse_id, end_verse_id) }
        subject { reference.includes_verse?(Verse.from_id(included_verse_id)) }
        it { is_expected.to eq expect_incuded }
      end
    end
  end

  describe "intersects_reference?" do
    [
      [1_001_010, nil, 1_001_010, nil, true],
      [1_001_010, 1_002_010, 1_002_011, 1_003_001, false],
      [1_001_010, 1_002_010, 1_002_010, 1_003_001, true],
      [1_001_010, 1_002_010, 1_002_009, 1_003_001, true],
      [1_001_010, 1_002_010, 1_001_001, 1_003_001, true],
      [1_001_010, 1_002_010, 1_001_001, 1_001_011, true],
      [1_001_010, 1_002_010, 1_001_001, 1_001_010, true],
      [1_001_010, 1_002_010, 1_001_001, 1_001_009, false],
    ].each do |ref1_start, ref1_end, ref2_start, ref2_end, intersect_expected|
      describe "ref1_start=#{ref1_start}, ref1_end=#{ref1_end}, ref2_start=#{ref2_start}, ref2_end=#{ref2_end}" do
        let(:reference1) { described_class.from_verse_ids(ref1_start, ref1_end) }
        let(:reference2) { described_class.from_verse_ids(ref2_start, ref2_end) }
        subject { reference1.intersects_reference? reference2 }
        it { is_expected.to eq intersect_expected }
      end
    end
  end

end
