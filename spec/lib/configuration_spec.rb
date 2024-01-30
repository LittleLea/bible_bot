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
      {ref: "Tob 1:1", expected: ["Tobit 1:1"]},
      {ref: "Judith 1:2", expected: ["Judith 1:2"]},
      {ref: "Ecclus 1:8", expected: ["Sirach 1:8"]},
      {ref: "Ps 151:2", expected: ["Psalm 151:2"]},
    ]

    test_cases.each do |t|
      it "Can parse \"#{t[:ref]}\"" do

        expect( ReferenceMatch.scan( t[:ref] ).map {|rm| rm.reference.formatted }).to eq t[:expected]
      end

      it "Can parse \"giberish 84 #{t[:ref]} foo bar\"" do
        BibleBot.include_apocryphal_content = true
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
