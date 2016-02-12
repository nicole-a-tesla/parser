require_relative '../page_parse_manager'
require_relative '../page_parser'
require_relative '../table_row_parser'
require_relative '../song'


describe PageParseManager do
  file = File.open("test/example.html", "rb")
  page_as_string = file.read


  let(:args) { { page_parser:    PageParser,
                 row_parser:     TableRowParser,
                 song:           Song,
                 page_as_string: page_as_string} }
  let(:parse_manager) { PageParseManager.new(args) }

  describe "turns rows into songs" do
    it "fills pages_songs array with one thing per song" do
      expect(parse_manager.pages_songs.size).to eq 25
    end

    it "each song is unique" do
      expect(parse_manager.pages_songs.uniq.size).to eq parse_manager.pages_songs.size
    end

    it "each song title is unique" do
      songs = parse_manager.pages_songs
      titles = songs.map { |s| s.title }

      expect(titles.uniq.size).to eq titles.size
    end

     it "fills pages_songs array with Song objects" do
       expect(parse_manager.pages_songs[rand(0..24)].class).to eq Song
     end
  end
end