class Session
  attr_accessor :title, :collection_title, :region, :date, :url, :songs
  def initialize(args)
    @title = args[:title]
    @collection_title = args[:collection_title]
    @region = args[:region]
    @date = args[:date]
    @url = args[:url]
    @songs = args[:songs]
  end

end
