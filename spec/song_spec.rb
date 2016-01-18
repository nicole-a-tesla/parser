require_relative "../song"

describe Song do
  let(:info) { {title:  "title",
                url:    "url.com",
                tags:    ["tag1", "tag2"],
                artists: ["Artist, Number One", "Artist Number, Two", "Young, Jr., Lonnie"]} }
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

    it "returns artist first name if they have 2 first names" do
      two_first_names = song.artists[0]
      expect(song.first_name(two_first_names)).to eq "Number One"
    end

    it "returns artist last name if they have 2 first names" do
      two_first_names = song.artists[0]
      expect(song.last_name(two_first_names)).to eq "Artist"
    end

    it "returns artist first name if they have 1 first name" do
      one_first_name = song.artists[1]
      expect(song.first_name(one_first_name)).to eq "Two"
    end

    it "returns artist last name if they have 1 first name" do
      two_first_names = song.artists[1]
      expect(song.last_name(two_first_names)).to eq "Artist Number"
    end

    it "returns artist first name if they're a Jr/Sr" do
      one_first_name = song.artists[2]
      expect(song.first_name(one_first_name)).to eq "Lonnie"
    end

    it "returns artist last name if they're a Jr/Sr" do
      two_first_names = song.artists[2]
      expect(song.last_name(two_first_names)).to eq "Young Jr."
    end

  end

  describe "tags" do
    it "stores and returns correct tags" do
      expect(song.tags).to eq info[:tags]
    end
  end

end