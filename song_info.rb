class SongInfo
  attr_reader :title, :url, :artists, :tags

  def initialize(info)
    @title = info[:title]
    @url = info[:url]
    @artists = info[:artists]
    @tags = info[:tags]
  end

end