require 'pry'

class Song
  attr_reader :title, :url, :artists, :tags

  def initialize(info)
    @title = info[:title]
    @url = info[:url]
    @artists = info[:artists]
    @tags = info[:tags]
  end

  def first_name(artist_string)
    artist_string.split(",")[1].strip()
  end

  def last_name(artist_string)
    artist_string.split(",")[0].strip()
  end

end