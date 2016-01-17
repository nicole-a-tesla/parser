require_relative "../song"

describe Song do
  let(:info) { {title:  "title",
                url:    "url.com",
                tags:    ["tag1", "tag2"],
                artists: ["artist1", "artist2"]} }
  let(:song) { Song.new(info) }

  describe "title" do
    it "stores and returns correct title" do
      expect(song.title).to eq info[:title]
    end
  end

  describe "url" do
    it "stores and returns correct url" do
      expect(song.url).to eq info[:url]
    end
  end

  describe "artists" do
    it "stores and returns correct artists" do
      expect(song.artists).to eq info[:artists]
    end
  end

  describe "tags" do
    it "stores and returns correct tags" do
      expect(song.tags).to eq info[:tags]
    end
  end

end