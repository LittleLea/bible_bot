require 'spec_helper'

describe BibleBot::Parser do

  let(:parser) { BibleBot::Parser.new }

  test_cases = [
    {ref: "John 1:1", expected: ["John 1:1"]},
    {ref: "John 1:1 is the first first but Romans 8:9-10 is another.", expected: ["John 1:1", "Romans 8:9-10"]},
    {ref: "When Fiery Trials Come Genesis 35:16-29 Part 1", expected: ["Genesis 35:16-29"]},
    {ref: "No book to see here 4:5", expected: []},
    {ref: "Rom 1:6", expected: ["Romans 1:6"]},
    {ref: "Romans 1:6", expected: ["Romans 1:6"]},
    {ref: "Rm 1:8", expected: ["Romans 1:8"]},
    {ref: "Ge 1:1", expected: ["Genesis 1:1"]},
    {ref: "Gen 1:1", expected: ["Genesis 1:1"]},
  ]

  test_cases.each do |t|
    it "Can parse #{t[:ref]}" do
      expect( parser.extract( t[:ref] ).map(&:formatted) ).to eq t[:expected]
    end
  end
end
