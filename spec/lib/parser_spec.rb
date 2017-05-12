require 'spec_helper'

describe BibleBot::Parser do

  it "Parses scripture" do
    p = BibleBot::Parser.new
    
    expect( p.extract( "John 1:1" ).length ).to eq 1

    expect( p.extract( "John 1:1 is the first first but Romans 8:9-10 is another." ).length ).to eq 2
  end
end