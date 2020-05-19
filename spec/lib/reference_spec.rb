require 'spec_helper'

describe BibleBot::Reference do
  describe "parse" do
    test_cases = [
      {ref: "Matthew 1:1 - Mark 4:2", expected: ["Matthew 1:1-Mark 4:2"]},
      {ref: "Matthew 2 - Mark 4", expected: ["Matthew 2-Mark 4"]},
      {ref: "John 1:1", expected: ["John 1:1"]},
      {ref: "John 1:1 is the first first but Romans 8:9-10 is another.", expected: ["John 1:1", "Romans 8:9-10"]},
      {ref: "When Fiery Trials Come Genesis 35:16-29 Part 1", expected: ["Genesis 35:16-29"]},
      {ref: "No book to see here 4:5", expected: []},
      {ref: "Rom 1:6", expected: ["Romans 1:6"]},
      {ref: "Romans 1:6", expected: ["Romans 1:6"]},
      {ref: "Rm 1:8", expected: ["Romans 1:8"]},
      {ref: "Ge 1:1", expected: ["Genesis 1:1"]},
      {ref: "Gen 1:1", expected: ["Genesis 1:1"]},
      {ref: "Genesis", expected: []},
      {ref: "Genesis 5", expected: ["Genesis 5"]},
      {ref: "Genesis 5-10", expected: ["Genesis 5-10"]},
      {ref: "Genesis 1:1 - Exod 4", expected: ["Genesis 1-Exodus 4"]},
      {ref: "Genesis 3 - Genesis 4:3", expected: ["Genesis 3:1-4:3"]},
      {ref: "Ex", expected: []},
      {ref: "Genesis 1:1", expected: ["Genesis 1:1"]},
      {ref: "Ge 1:1", expected: ["Genesis 1:1"]},
      {ref: "Gen 1:1", expected: ["Genesis 1:1"]},
      {ref: "Exodus 1:1", expected: ["Exodus 1:1"]},
      {ref: "Ex 1:1", expected: ["Exodus 1:1"]},
      {ref: "Exod 1:1", expected: ["Exodus 1:1"]},
      {ref: "Leviticus 1:1", expected: ["Leviticus 1:1"]},
      {ref: "Lev 1:1", expected: ["Leviticus 1:1"]},
      {ref: "Numbers 1:1", expected: ["Numbers 1:1"]},
      {ref: "Num 1:1", expected: ["Numbers 1:1"]},
      {ref: "Deuteronomy 1:1", expected: ["Deuteronomy 1:1"]},
      {ref: "Deut 1:1", expected: ["Deuteronomy 1:1"]},
      {ref: "Joshua 1:1", expected: ["Joshua 1:1"]},
      {ref: "Josh 1:1", expected: ["Joshua 1:1"]},
      {ref: "Judges 1:1", expected: ["Judges 1:1"]},
      {ref: "Judg 1:1", expected: ["Judges 1:1"]},
      {ref: "Ruth 1:1", expected: ["Ruth 1:1"]},
      {ref: "1 Samuel 1:1", expected: ["1 Samuel 1:1"]},
      {ref: "1 Sam 1:1", expected: ["1 Samuel 1:1"]},
      {ref: "2 Samuel 1:1", expected: ["2 Samuel 1:1"]},
      {ref: "2 Sam 1:1", expected: ["2 Samuel 1:1"]},
      {ref: "1 Kings 1:1", expected: ["1 Kings 1:1"]},
      {ref: "1 Kgs 1:1", expected: ["1 Kings 1:1"]},
      {ref: "2 Kings 1:1", expected: ["2 Kings 1:1"]},
      {ref: "2 Kgs 1:1", expected: ["2 Kings 1:1"]},
      {ref: "1 Chronicles 1:1", expected: ["1 Chronicles 1:1"]},
      {ref: "1 Chron 1:1", expected: ["1 Chronicles 1:1"]},
      {ref: "2 Chronicles 1:1", expected: ["2 Chronicles 1:1"]},
      {ref: "2 Chron 1:1", expected: ["2 Chronicles 1:1"]},
      {ref: "Ezra 1:1", expected: ["Ezra 1:1"]},
      {ref: "Nehemiah 1:1", expected: ["Nehemiah 1:1"]},
      {ref: "Neh 1:1", expected: ["Nehemiah 1:1"]},
      {ref: "Esther 1:1", expected: ["Esther 1:1"]},
      {ref: "Esth 1:1", expected: ["Esther 1:1"]},
      {ref: "Job 1:1", expected: ["Job 1:1"]},
      {ref: "Psalms 1:1", expected: ["Psalm 1:1"]},
      {ref: "Psalm 1:1", expected: ["Psalm 1:1"]},
      {ref: "Psa 1:1", expected: ["Psalm 1:1"]},
      {ref: "Ps 1:1", expected: ["Psalm 1:1"]},
      {ref: "Proverbs 1:1", expected: ["Proverbs 1:1"]},
      {ref: "Prov 1:1", expected: ["Proverbs 1:1"]},
      {ref: "Ecclesiastes 1:1", expected: ["Ecclesiastes 1:1"]},
      {ref: "Ecc 1:1", expected: ["Ecclesiastes 1:1"]},
      {ref: "Song of Solomon 1:1", expected: ["Song of Solomon 1:1"]},
      {ref: "Song of Songs 1:1", expected: ["Song of Solomon 1:1"]},
      {ref: "Song 1:1", expected: ["Song of Solomon 1:1"]},
      {ref: "Isaiah 1:1", expected: ["Isaiah 1:1"]},
      {ref: "Isa 1:1", expected: ["Isaiah 1:1"]},
      {ref: "Jeremiah 1:1", expected: ["Jeremiah 1:1"]},
      {ref: "Jer 1:1", expected: ["Jeremiah 1:1"]},
      {ref: "Lamentations 1:1", expected: ["Lamentations 1:1"]},
      {ref: "Lam 1:1", expected: ["Lamentations 1:1"]},
      {ref: "Ezekiel 1:1", expected: ["Ezekiel 1:1"]},
      {ref: "Ezek 1:1", expected: ["Ezekiel 1:1"]},
      {ref: "Daniel 1:1", expected: ["Daniel 1:1"]},
      {ref: "Dan 1:1", expected: ["Daniel 1:1"]},
      {ref: "Hosea 1:1", expected: ["Hosea 1:1"]},
      {ref: "Hos 1:1", expected: ["Hosea 1:1"]},
      {ref: "Joel 1:1", expected: ["Joel 1:1"]},
      {ref: "Amos 1:1", expected: ["Amos 1:1"]},
      {ref: "Obadiah 1:1", expected: ["Obadiah 1"]},
      {ref: "Obad 1:1", expected: ["Obadiah 1"]},
      {ref: "Jonah 1:1", expected: ["Jonah 1:1"]},
      {ref: "Micah 1:1", expected: ["Micah 1:1"]},
      {ref: "Mic 1:1", expected: ["Micah 1:1"]},
      {ref: "Nahum 1:1", expected: ["Nahum 1:1"]},
      {ref: "Nah 1:1", expected: ["Nahum 1:1"]},
      {ref: "Habakkuk 1:1", expected: ["Habakkuk 1:1"]},
      {ref: "Hab 1:1", expected: ["Habakkuk 1:1"]},
      {ref: "Zephaniah 1:1", expected: ["Zephaniah 1:1"]},
      {ref: "Zeph 1:1", expected: ["Zephaniah 1:1"]},
      {ref: "Haggai 1:1", expected: ["Haggai 1:1"]},
      {ref: "Hag 1:1", expected: ["Haggai 1:1"]},
      {ref: "Zechariah 1:1", expected: ["Zechariah 1:1"]},
      {ref: "Zech 1:1", expected: ["Zechariah 1:1"]},
      {ref: "Malachi 1:1", expected: ["Malachi 1:1"]},
      {ref: "Mal 1:1", expected: ["Malachi 1:1"]},
      {ref: "Matthew 1:1", expected: ["Matthew 1:1"]},
      {ref: "Matt 1:1", expected: ["Matthew 1:1"]},
      {ref: "Mt 1:1", expected: ["Matthew 1:1"]},
      {ref: "Mark 1:1", expected: ["Mark 1:1"]},
      {ref: "Mk 1:1", expected: ["Mark 1:1"]},
      {ref: "Luke 1:1", expected: ["Luke 1:1"]},
      {ref: "Lk 1:1", expected: ["Luke 1:1"]},
      {ref: "John 1:1", expected: ["John 1:1"]},
      {ref: "Jn 1:1", expected: ["John 1:1"]},
      {ref: "Acts 1:1", expected: ["Acts 1:1"]},
      {ref: "Romans 1:1", expected: ["Romans 1:1"]},
      {ref: "Rom 1:1", expected: ["Romans 1:1"]},
      {ref: "1 Corinthians 1:1", expected: ["1 Corinthians 1:1"]},
      {ref: "1 Cor 1:1", expected: ["1 Corinthians 1:1"]},
      {ref: "2 Corinthians 1:1", expected: ["2 Corinthians 1:1"]},
      {ref: "2 Cor 1:1", expected: ["2 Corinthians 1:1"]},
      {ref: "Galatians 1:1", expected: ["Galatians 1:1"]},
      {ref: "Gal 1:1", expected: ["Galatians 1:1"]},
      {ref: "Ephesians 1:1", expected: ["Ephesians 1:1"]},
      {ref: "Eph 1:1", expected: ["Ephesians 1:1"]},
      {ref: "Philippians 1:1", expected: ["Philippians 1:1"]},
      {ref: "Phil 1:1", expected: ["Philippians 1:1"]},
      {ref: "Colossians 1:1", expected: ["Colossians 1:1"]},
      {ref: "Col 1:1", expected: ["Colossians 1:1"]},
      {ref: "1 Thessalonians 1:1", expected: ["1 Thessalonians 1:1"]},
      {ref: "1 Thess 1:1", expected: ["1 Thessalonians 1:1"]},
      {ref: "2 Thessalonians 1:1", expected: ["2 Thessalonians 1:1"]},
      {ref: "2 Thess 1:1", expected: ["2 Thessalonians 1:1"]},
      {ref: "1 Timothy 1:1", expected: ["1 Timothy 1:1"]},
      {ref: "1 Tim 1:1", expected: ["1 Timothy 1:1"]},
      {ref: "2 Timothy 1:1", expected: ["2 Timothy 1:1"]},
      {ref: "2 Tim 1:1", expected: ["2 Timothy 1:1"]},
      {ref: "Titus 1:1", expected: ["Titus 1:1"]},
      {ref: "Tit 1:1", expected: ["Titus 1:1"]},
      {ref: "Philemon 1:1", expected: ["Philemon 1"]},
      {ref: "Philem 1:1", expected: ["Philemon 1"]},
      {ref: "Hebrews 1:1", expected: ["Hebrews 1:1"]},
      {ref: "Heb 1:1", expected: ["Hebrews 1:1"]},
      {ref: "James 1:1", expected: ["James 1:1"]},
      {ref: "Jas 1:1", expected: ["James 1:1"]},
      {ref: "1 Peter 1:1", expected: ["1 Peter 1:1"]},
      {ref: "1 Pet 1:1", expected: ["1 Peter 1:1"]},
      {ref: "2 Peter 1:1", expected: ["2 Peter 1:1"]},
      {ref: "2 Pet 1:1", expected: ["2 Peter 1:1"]},
      {ref: "1 John 1:1", expected: ["1 John 1:1"]},
      {ref: "I John 1:1", expected: ["1 John 1:1"]},
      {ref: "1 Jn 1:1", expected: ["1 John 1:1"]},
      {ref: "2 John 1:1", expected: ["2 John 1"]},
      {ref: "II John 1:1", expected: ["2 John 1"]},
      {ref: "2 Jn 1:1", expected: ["2 John 1"]},
      {ref: "3 John 1:1", expected: ["3 John 1"]},
      {ref: "III John 1:1", expected: ["3 John 1"]},
      {ref: "3 Jn 1:1", expected: ["3 John 1"]},
      {ref: "Jude 1:1", expected: ["Jude 1"]},
      {ref: "Jude 5", expected: ["Jude 5"]},
      {ref: "Revelation 1:1", expected: ["Revelation 1:1"]},
      {ref: "Rev 1:1", expected: ["Revelation 1:1"]},
    ]

    test_cases.each do |t|
      it "Can parse #{t[:ref]}" do
        expect( Reference.parse( t[:ref] ).map(&:formatted) ).to eq t[:expected]
      end

      it "Can parse \"giberish 84 #{t[:ref]} foo bar\"" do
        expect( Reference.parse( "giberish 84 #{t[:ref]} foo bar" ).map(&:formatted) ).to eq t[:expected]
      end
    end

    describe "invalid references" do
      invalid_references = [
        ["Genesis 51:4", BibleBot::InvalidVerseError],
        ["Rom 1:99", BibleBot::InvalidVerseError],
        ["Rom 0:1", BibleBot::InvalidVerseError],
        ["Rom 1:0", BibleBot::InvalidVerseError],
        ["Romans 5:2-4:11", BibleBot::InvalidReferenceError],
      ]

      invalid_references.each do |ref, expected_error|
        it "raises error when parsing #{ref}" do
          expect{ Reference.parse(ref) }.to raise_error(expected_error)
        end
      end

      context "ignore_errors=true" do
        # TODO: Look into why it is matching the Genesis ref twice
        let(:ref) { "Genesis 51:4 and Psalm 1:1-4 and Rom 1:99 are not all valid references" }
        it "ignores errors" do
          expect{ Reference.parse(ref) }.to raise_error(BibleBot::InvalidVerseError)
          expect( Reference.parse(ref, ignore_errors: true).map(&:formatted) ).to eq(['Psalm 1:1-4'])
        end
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
