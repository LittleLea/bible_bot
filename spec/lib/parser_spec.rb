require 'spec_helper'

describe BibleBot::Parser do

  it "Parses scripture" do
    p = BibleBot::Parser.new
    
    expect( p.extract( "John 1:1" ).length ).to eq 1
  end

end