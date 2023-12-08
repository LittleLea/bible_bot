require 'spec_helper'

describe BibleBot::Bible do
  %i[id name abbreviation regex testament chapters].each do |field|
    it "has sets #{field} for all books", :aggregate_failures do
      described_class.books.each do |book|
        expect(book.public_send(field)).to_not be_nil
      end
    end
  end
end
