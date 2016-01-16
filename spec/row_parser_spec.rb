require_relative '../table_row_parser'
require_relative '../page_parser'

describe TableRowParser do
  page_as_string = File.open("test/example.html", "rb").read
  let(:page_parser) { PageParser.new(page_as_string) }
  let(:rows) { page_parser.rows }
  let(:row_parser) { TableRowParser.new(rows[0]) }

  describe "title" do
    it "gets and correctly formats title" do
      correct_title = "1_Commentary_by_Vera_Hall_on_courtship_games_and_riddles_T805R01__Vera_Hall_I_1948"
      expect(row_parser.title).to eq correct_title
    end
  end

  describe "url" do
    it "gets the download url" do
      correct_url = "http://c0383352.cdn.cloudfiles.rackspacecloud.com/audio/T805R01.mp3"
      expect(row_parser.url).to eq correct_url
    end
  end

  describe "artists" do
    it "can get multiple artists" do
      expect(row_parser.artists.size).to eq 2
    end

    it "gets first artist correct" do
      expect(row_parser.artists[0]).to eq "Hall, Vera Ward"
    end

    it "gets a second artist correct" do
      expect(row_parser.artists[1]).to eq "Lomax, Alan"
    end
  end

  describe "tags" do
    it "gets the tags" do
      expect(row_parser.tags.size).to eq 2
    end

    it "gets the first tag correct" do
      first_tag = "commentary"
      expect(row_parser.tags[0]).to eq first_tag
    end

    it "gets a second tag correct" do
      second_tag = "spoken"
      expect(row_parser.tags[1]).to eq second_tag
    end
  end
end