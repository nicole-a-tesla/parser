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

  describe "songs array" do
    it "starts out empty" do
      expect(parse_manager.pages_songs).to eq []
    end
  end

  describe "turns rows into songs" do
    it "fills pages_songs array with one thing per song" do
      parse_manager.turn_rows_into_songs
      expect(parse_manager.pages_songs.size).to eq 25
    end

     it "fills pages_songs array with Song objects" do
       parse_manager.turn_rows_into_songs
       expect(parse_manager.pages_songs[rand(0..25)].class).to eq Song
     end
  end
end