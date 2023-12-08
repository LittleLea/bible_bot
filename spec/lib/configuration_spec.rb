require 'spec_helper'

describe BibleBot do

  describe "scan with deuterocanonical content enabled" do
    before(:each) do
      BibleBot.include_deuterocanonical_content = true
    end

    it "has a config" do
      expect(BibleBot.include_deuterocanonical_content?).to eq true
    end

    test_cases = [
      {ref: "Tob 1:1", expected: ["Tobit 1:1"]},
      {ref: "Judith 1:2", expected: ["Judith 1:2"]},
      {ref: "Ecclus 1:8", expected: ["Sirach (Ecclesiasticus) 1:8"]},
      {ref: "Ode 151:2", expected: ["Ode 151:2"]},
    ]

    test_cases.each do |t|
      it "Can parse \"#{t[:ref]}\"" do

        expect( ReferenceMatch.scan( t[:ref] ).map {|rm| rm.reference.formatted }).to eq t[:expected]
      end

      it "Can parse \"giberish 84 #{t[:ref]} foo bar\"" do
        BibleBot.include_deuterocanonical_content = true
        expect( ReferenceMatch.scan( "giberish 84 #{t[:ref]} foo bar" ).map {|rm| rm.reference.formatted }).to eq t[:expected]
      end
    end
  end

  describe "scan with deuterocanonical content disabled" do
    before(:each) do
      BibleBot.include_deuterocanonical_content = false
    end

    it "has a config" do
      expect(BibleBot.include_deuterocanonical_content?).to eq false
    end

    test_cases = [
      {ref: "John 1:1", expected: ["John 1:1"]},
      {ref: "Tob 1:1", expected: []},
      {ref: "Ode 151:2", expected: []},
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
