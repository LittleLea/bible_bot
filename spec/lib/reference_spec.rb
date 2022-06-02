require 'spec_helper'

describe BibleBot::Reference do
  describe "parse" do
    [
      ["Genesis 1:1", true, nil],
      ['Genesis 1-3', true, nil],
      ["Genesis 51:4", false, InvalidVerseError],
      ["Romans 5:2-4:11", false, InvalidReferenceError],
    ].each do |ref, expected_valid, expected_error|
      context "parsing \"#{ref}\"" do
        let(:references) { Reference.parse(ref) }

        it "skips invalid references" do
          expect(references.count).to eq(expected_valid ? 1 : 0)
        end

        context "validate=false" do
          let(:references) { Reference.parse(ref, validate: false) }

          it "#{expected_valid ? 'is' : 'is not'} valid" do
            expect(references.all?(&:valid?)).to be expected_valid
          end

          it "calls formatted without errors" do
            expect(references.first.formatted).to be_a String
          end
        end

        context "validate=:raise_errors" do
          let(:references) { Reference.parse(ref, validate: :raise_errors) }

          if expected_valid
            it "includes valid references" do
              expect(references.all?(&:valid?)).to be true
            end
          else
            it "raises error" do
              expect{ references }.to raise_error(expected_error)
            end
          end
        end
      end
    end
  end

  describe 'normalize' do
    [
      ['Num 1-2', 'Numbers 1-2'],
      [" Ps \n 1; Gen 1 -2", 'Psalm 1, Genesis 1-2'], # odd spacing & semicolons
      ['Ps 1:3-4:5', 'Psalm 1:3-4:5'],
      ['Phil 1-4', 'Philippians 1-4'], # hyphen
      ['Phil 1–4', 'Philippians 1-4'], # endash
      ['Phil 1—4', 'Philippians 1-4'], # emdash
      ['Philem 1', 'Philemon 1'],  # single-chapter book
      ['Philemon 1:1-25', 'Philemon 1'], # whole chapter
      ['Philemon 1:1-24', 'Philemon 1:1-24'], # partial chapter
    ].each do |given, expected|
      it %Q|normalizes the "#{given}" to "#{expected}"| do
        expect(described_class.normalize(given)).to eq(expected)
      end
    end
  end

  describe "formatted" do
    [
      [1_001_001, nil, "Genesis 1:1"],
      [1_001_001, 1_001_001, "Genesis 1:1"],
      [1_001_001, 1_001_030, "Genesis 1:1-30"],
      [1_001_001, 1_001_031, "Genesis 1"], # Leaves out verses when range includes the entire chapter
      [1_001_001, 1_002_004, "Genesis 1:1-2:4"],
      [1_001_001, 1_002_025, "Genesis 1-2"],
      [1_002_003, 1_003_003, "Genesis 2:3-3:3"],
      [65_001_001, 65_001_006, "Jude 1:1-6"],
      [65_001_001, 65_001_025, "Jude 1"],
      [65_001_001, 66_001_015, "Jude 1:1-Revelation 1:15"],
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

  describe "self.from_verse_ids" do
    context "using Integer verse IDs" do
      let(:reference) { Reference.from_verse_ids(1_001_001, 1_005_002) }

      it "Successfully initializes Reference" do
        expect(reference.formatted).to eq("Genesis 1:1-5:2")
      end
    end

    context "using deprecated String verse IDs" do
      let(:reference) { Reference.from_verse_ids("genesis-001-001", "genesis-005-002") }

      it "Successfully initializes Reference" do
        expect(reference.formatted).to eq("Genesis 1:1-5:2")
      end
    end
  end
end
