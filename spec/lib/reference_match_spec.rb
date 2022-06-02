require 'spec_helper'

describe BibleBot::ReferenceMatch do
  describe "scan" do
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
      {ref: "Genesis 5-10", expected: ["Genesis 5-10"]}, # hyphen
      {ref: "Genesis 5–10", expected: ["Genesis 5-10"]}, # en dash
      {ref: "Genesis 5—10", expected: ["Genesis 5-10"]}, # em dash
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
      {ref: "Obadiah 1:1", expected: ["Obadiah 1:1"]},
      {ref: "Obad 1:1", expected: ["Obadiah 1:1"]},
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
      {ref: "Philemon 1:1", expected: ["Philemon 1:1"]},
      {ref: "Philem 1:1", expected: ["Philemon 1:1"]},
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
      {ref: "2 John 1:1", expected: ["2 John 1:1"]},
      {ref: "II John 1:1", expected: ["2 John 1:1"]},
      {ref: "2 Jn 1:1", expected: ["2 John 1:1"]},
      {ref: "3 John 1:1", expected: ["3 John 1:1"]},
      {ref: "III John 1:1", expected: ["3 John 1:1"]},
      {ref: "3 Jn 1:1", expected: ["3 John 1:1"]},
      {ref: "Jude 1:1", expected: ["Jude 1:1"]},
      {ref: "Revelation 1:1", expected: ["Revelation 1:1"]},
      {ref: "Rev 1:1", expected: ["Revelation 1:1"]},
      {ref: "Genesis 13:11b-12", expected: ["Genesis 13:11-12"]}
    ]

    test_cases.each do |t|
      it %Q|Can parse "#{t[:ref]}"| do
        actual = ReferenceMatch.scan(t[:ref]).map { |rm| rm.reference.formatted }

        expect(actual).to eq t[:expected]
      end

      it %Q|Can parse "giberish 84 #{t[:ref]} foo bar"| do
        actual = ReferenceMatch.scan("giberish 84 #{t[:ref]} foo bar").
          map { |rm| rm.reference.formatted }

        expect(actual).to eq t[:expected]
      end
    end
  end

  describe "length and offset" do
    let(:text) { "John 1:1 is the first first but Romans 8:9-10 is another." }
    let(:matches) { ReferenceMatch.scan(text) }

    it "stores the correct length and offset for each match" do
      expect(matches[0].offset).to eq 0
      expect(matches[0].length).to eq 8
      expect(matches[1].offset).to eq 32
      expect(matches[1].length).to eq 13
    end
  end
end
