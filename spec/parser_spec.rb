require 'nokogiri'
require 'pry'
require_relative '../page_parser'

describe PageParser do
  page_as_string = File.open("test/example.html", "rb").read
  let(:parser) { PageParser.new(page_as_string) }

  describe "initialize" do
    it "makes the string into a nokogiri object" do
      noko_class = Nokogiri::HTML(page_as_string).class
      expect(parser.doc.class).to eq noko_class
    end
  end

  describe "parse_rows" do
    it "rows are an array" do
      expect(parser.rows.class).to eq Array
    end

    it "rows elements are arrays" do
      expect(parser.rows[0].class).to eq Array
    end

    it "row elements are of size 3" do
      expect(parser.rows[0].size).to eq 3
    end
  end
end

