require 'spec_helper'

describe BibleBot::Parser do
  
  before(:all) do
    @p = BibleBot::Parser.new
  end

  it "Parses scripture" do
    expect( @p.extract( "John 1:1" ).length ).to eq 1

    expect( @p.extract( "John 1:1 is the first first but Romans 8:9-10 is another." ).length ).to eq 2
        

    expect( @p.extract( "When Fiery Trials Come Genesis 35:16-29" ).length ).to eq 1
  end
  
  abbreviation_tests_cases = [
    {ref: "Rom 1:6", expected: "Romans 1:6"},
    {ref: "Romans 1:6", expected: "Romans 1:6"},
    {ref: "Rm 1:8", expected: "Romans 1:8"},
    {ref: "Ge 1:1", expected: "Genesis 1:1"},
    {ref: "Gen 1:1", expected: "Genesis 1:1"}
  ]
  
  abbreviation_tests_cases.each do |t|
    it "Can parse #{t[:ref]}" do
      expect( @p.extract( t[:ref] )[0].formatted ).to eq t[:expected]
    end
  end
  
  
end