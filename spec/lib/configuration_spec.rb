require 'spec_helper'

describe BibleBot do

  describe "scan with apocryphal content enabled" do
    before(:each) do
      BibleBot.include_apocryphal_content = true
    end

    it "has a config" do
      expect(BibleBot.include_apocryphal_content?).to eq true
    end

    test_cases = [
      {ref: "Tobit 1:1", expected: ["Tobit 1:1"]},
      {ref: "Tob 1:1", expected: ["Tobit 1:1"]},
      {ref: "Tb 1:1", expected: ["Tobit 1:1"]},

      {ref: "Judith 1:2", expected: ["Judith 1:2"]},
      {ref: "Jth 1:2", expected: ["Judith 1:2"]},
      {ref: "Jdth 1:2", expected: ["Judith 1:2"]},
      {ref: "Jdt 1:2", expected: ["Judith 1:2"]},

      {ref: "Additions to Esther 1:2", expected: ["Additions to Esther 1:2"]},
      {ref: "Add Esth 1:2", expected: ["Additions to Esther 1:2"]},
      {ref: "Add Es 1:2", expected: ["Additions to Esther 1:2"]},
      {ref: "Rest of Esther 1:2", expected: ["Additions to Esther 1:2"]},
      {ref: "The Rest of Esther 1:2", expected: ["Additions to Esther 1:2"]},
      {ref: "AEs 1:2", expected: ["Additions to Esther 1:2"]},
      {ref: "AddEsth 1:2", expected: ["Additions to Esther 1:2"]},

      {ref: "Wisdom of Solomon 1:2", expected: ["Wisdom of Solomon 1:2"]},
      {ref: "Wis of Sol 1:2", expected: ["Wisdom of Solomon 1:2"]},
      {ref: "Wis 1:2", expected: ["Wisdom of Solomon 1:2"]},
      {ref: "Ws 1:2", expected: ["Wisdom of Solomon 1:2"]},

      {ref: "Sirach 1:8", expected: ["Sirach 1:8"]},
      {ref: "Sir 1:8", expected: ["Sirach 1:8"]},
      {ref: "Ecclus 1:8", expected: ["Sirach 1:8"]},
      {ref: "Ecclesiasticus 1:8", expected: ["Sirach 1:8"]},

      {ref: "Baruch 1:3", expected: ["Baruch 1:3"]},
      {ref: "Bar 1:3", expected: ["Baruch 1:3"]},

      {ref: "Letter of Jeremiah 1:3", expected: ["Letter of Jeremiah 1:3"]},
      {ref: "Ep Jer 1:3", expected: ["Letter of Jeremiah 1:3"]},
      {ref: "Let Jer 1:3", expected: ["Letter of Jeremiah 1:3"]},
      {ref: "Ltr Jer 1:3", expected: ["Letter of Jeremiah 1:3"]},
      {ref: "LJe 1:3", expected: ["Letter of Jeremiah 1:3"]},

      {ref: "Prayer of Azariah and the Song of the Three Jews 1:1", expected: ["Prayer of Azariah and the Song of the Three Jews 1:1"]},
      {ref: "Sg of 3 Childr 1:1", expected: ["Prayer of Azariah and the Song of the Three Jews 1:1"]},
      {ref: "Song of Three 1:1", expected: ["Prayer of Azariah and the Song of the Three Jews 1:1"]},
      {ref: "Song of Thr 1:1", expected: ["Prayer of Azariah and the Song of the Three Jews 1:1"]},
      {ref: "Song Thr 1:1", expected: ["Prayer of Azariah and the Song of the Three Jews 1:1"]},
      {ref: "Song of the Three Holy Children 1:1", expected: ["Prayer of Azariah and the Song of the Three Jews 1:1"]},
      {ref: "Song of Three Children 1:1", expected: ["Prayer of Azariah and the Song of the Three Jews 1:1"]},
      {ref: "The Song of Three Jews 1:1", expected: ["Prayer of Azariah and the Song of the Three Jews 1:1"]},
      {ref: "Song of Three Jews 1:1", expected: ["Prayer of Azariah and the Song of the Three Jews 1:1"]},
      {ref: "Prayer of Azariah 1:1", expected: ["Prayer of Azariah and the Song of the Three Jews 1:1"]},
      {ref: "Azariah 1:1", expected: ["Prayer of Azariah and the Song of the Three Jews 1:1"]},
      {ref: "Pr Az 1:1", expected: ["Prayer of Azariah and the Song of the Three Jews 1:1"]},

      {ref: "Susanna 1:1", expected: ["Susanna 1:1"]},
      {ref: "Sus 1:1", expected: ["Susanna 1:1"]},

      {ref: "Bel and the Dragon 1:1", expected: ["Bel and the Dragon 1:1"]},
      {ref: "Bel and Dr 1:1", expected: ["Bel and the Dragon 1:1"]},
      {ref: "Bel 1:1", expected: ["Bel and the Dragon 1:1"]},

      {ref: "1 Maccabees 1:1", expected: ["1 Maccabees 1:1"]},
      {ref: "1 Mac 1:1", expected: ["1 Maccabees 1:1"]},
      {ref: "1Maccabees 1:1", expected: ["1 Maccabees 1:1"]},
      {ref: "1Macc 1:1", expected: ["1 Maccabees 1:1"]},
      {ref: "1Ma 1:1", expected: ["1 Maccabees 1:1"]},
      {ref: "1M 1:1", expected: ["1 Maccabees 1:1"]},
      {ref: "I Maccabees 1:1", expected: ["1 Maccabees 1:1"]},
      {ref: "I Macc 1:1", expected: ["1 Maccabees 1:1"]},
      {ref: "I Mac 1:1", expected: ["1 Maccabees 1:1"]},
      {ref: "I Ma 1:1", expected: ["1 Maccabees 1:1"]},
      {ref: "1st Maccabees 1:1", expected: ["1 Maccabees 1:1"]},
      {ref: "First Maccabees 1:1", expected: ["1 Maccabees 1:1"]},

      {ref: "2 Maccabees 1:1", expected: ["2 Maccabees 1:1"]},
      {ref: "2 Mac 1:1", expected: ["2 Maccabees 1:1"]},
      {ref: "2Maccabees 1:1", expected: ["2 Maccabees 1:1"]},
      {ref: "2Macc 1:1", expected: ["2 Maccabees 1:1"]},
      {ref: "2Ma 1:1", expected: ["2 Maccabees 1:1"]},
      {ref: "2M 1:1", expected: ["2 Maccabees 1:1"]},
      {ref: "II Maccabees 1:1", expected: ["2 Maccabees 1:1"]},
      {ref: "II Macc 1:1", expected: ["2 Maccabees 1:1"]},
      {ref: "II Mac 1:1", expected: ["2 Maccabees 1:1"]},
      {ref: "II Ma 1:1", expected: ["2 Maccabees 1:1"]},
      {ref: "2nd Maccabees 1:1", expected: ["2 Maccabees 1:1"]},
      {ref: "Second Maccabees 1:1", expected: ["2 Maccabees 1:1"]},

      {ref: "1 Esdras 1:1", expected: ["1 Esdras 1:1"]},
      {ref: "1 Esdr 1:1", expected: ["1 Esdras 1:1"]},
      {ref: "1 Esd 1:1", expected: ["1 Esdras 1:1"]},
      {ref: "1Esdras 1:1", expected: ["1 Esdras 1:1"]},
      {ref: "1Esdr 1:1", expected: ["1 Esdras 1:1"]},
      {ref: "1Esd 1:1", expected: ["1 Esdras 1:1"]},
      {ref: "I Esdras 1:1", expected: ["1 Esdras 1:1"]},
      {ref: "I Esdr 1:1", expected: ["1 Esdras 1:1"]},
      {ref: "I Esd 1:1", expected: ["1 Esdras 1:1"]},
      {ref: "1st Esdras 1:1", expected: ["1 Esdras 1:1"]},
      {ref: "First Esdras 1:1", expected: ["1 Esdras 1:1"]},

      {ref: "Prayer of Manasseh 1:1", expected: ["Prayer of Manasseh 1:1"]},
      {ref: "Pr of Man 1:1", expected: ["Prayer of Manasseh 1:1"]},
      {ref: "PMa 1:1", expected: ["Prayer of Manasseh 1:1"]},
      {ref: "Prayer of Manasses 1:1", expected: ["Prayer of Manasseh 1:1"]},

      {ref: "Psalms 151 1:1", expected: ["Psalm 151 1:1"]},
      {ref: "Psalm 151 1:1", expected: ["Psalm 151 1:1"]},
      {ref: "Psa 151 1:1", expected: ["Psalm 151 1:1"]},
      {ref: "Psm 151 1:1", expected: ["Psalm 151 1:1"]},
      {ref: "Pss 151 1:1", expected: ["Psalm 151 1:1"]},
      {ref: "Ps 151 1:1", expected: ["Psalm 151 1:1"]},

      {ref: "3 Maccabees 1:1", expected: ["3 Maccabees 1:1"]},
      {ref: "3 Mac 1:1", expected: ["3 Maccabees 1:1"]},
      {ref: "3Maccabees 1:1", expected: ["3 Maccabees 1:1"]},
      {ref: "3Macc 1:1", expected: ["3 Maccabees 1:1"]},
      {ref: "3Ma 1:1", expected: ["3 Maccabees 1:1"]},
      {ref: "3M 1:1", expected: ["3 Maccabees 1:1"]},
      {ref: "III Maccabees 1:1", expected: ["3 Maccabees 1:1"]},
      {ref: "III Macc 1:1", expected: ["3 Maccabees 1:1"]},
      {ref: "III Mac 1:1", expected: ["3 Maccabees 1:1"]},
      {ref: "III Ma 1:1", expected: ["3 Maccabees 1:1"]},
      {ref: "3rd Maccabees 1:1", expected: ["3 Maccabees 1:1"]},
      {ref: "Third Maccabees 1:1", expected: ["3 Maccabees 1:1"]},

      {ref: "2 Esdras 1:1", expected: ["2 Esdras 1:1"]},
      {ref: "2 Esdr 1:1", expected: ["2 Esdras 1:1"]},
      {ref: "2 Esd 1:1", expected: ["2 Esdras 1:1"]},
      {ref: "2Esdras 1:1", expected: ["2 Esdras 1:1"]},
      {ref: "2Esdr 1:1", expected: ["2 Esdras 1:1"]},
      {ref: "2Esd 1:1", expected: ["2 Esdras 1:1"]},
      {ref: "II Esdras 1:1", expected: ["2 Esdras 1:1"]},
      {ref: "II Esdr 1:1", expected: ["2 Esdras 1:1"]},
      {ref: "II Esd 1:1", expected: ["2 Esdras 1:1"]},
      {ref: "2nd Esdras 1:1", expected: ["2 Esdras 1:1"]},
      {ref: "Second Esdras 1:1", expected: ["2 Esdras 1:1"]},

      {ref: "4 Maccabees 1:1", expected: ["4 Maccabees 1:1"]},
      {ref: "4 Mac 1:1", expected: ["4 Maccabees 1:1"]},
      {ref: "4Maccabees 1:1", expected: ["4 Maccabees 1:1"]},
      {ref: "4Macc 1:1", expected: ["4 Maccabees 1:1"]},
      {ref: "4Ma 1:1", expected: ["4 Maccabees 1:1"]},
      {ref: "4M 1:1", expected: ["4 Maccabees 1:1"]},
      {ref: "IV Maccabees 1:1", expected: ["4 Maccabees 1:1"]},
      {ref: "IV Macc 1:1", expected: ["4 Maccabees 1:1"]},
      {ref: "IV Mac 1:1", expected: ["4 Maccabees 1:1"]},
      {ref: "IV Ma 1:1", expected: ["4 Maccabees 1:1"]},
      {ref: "4th Maccabees 1:1", expected: ["4 Maccabees 1:1"]},
      {ref: "Fourth Maccabees 1:1", expected: ["4 Maccabees 1:1"]},
    ]

    test_cases.each do |t|
      it "Can parse \"#{t[:ref]}\"" do
        expect( ReferenceMatch.scan( t[:ref] ).map {|rm| rm.reference.formatted }).to eq t[:expected]
      end

      it "Can parse \"giberish 84 #{t[:ref]} foo bar\"" do
        expect( ReferenceMatch.scan( "giberish 84 #{t[:ref]} foo bar" ).map {|rm| rm.reference.formatted }).to eq t[:expected]
      end
    end
  end

  describe "scan with apocryphal content disabled" do
    before(:each) do
      BibleBot.include_apocryphal_content = false
    end

    it "has a config" do
      expect(BibleBot.include_apocryphal_content?).to eq false
    end

    test_cases = [
      {ref: "John 1:1", expected: ["John 1:1"]},
      {ref: "Tob 1:1", expected: []},
      {ref: "Ecclus 1:8", expected: []},
    ]

    test_cases.each do |t|
      it "Can parse \"#{t[:ref]}\"" do
        expect( ReferenceMatch.scan( t[:ref] ).map {|rm| rm.reference.formatted }).to eq t[:expected]
      end

      it "Can parse \"giberish 84 #{t[:ref]} foo bar\"" do
        expect( ReferenceMatch.scan( "giberish 84 #{t[:ref]} foo bar" ).map {|rm| rm.reference.formatted }).to eq t[:expected]
      end
    end
  end
end
