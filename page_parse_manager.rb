require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative "table_row_parser"
require_relative "page_parser"
require_relative "song"

# url = "http://research.culturalequity.org/get-audio-ix.do?ix=recording&id=10500&idType=sessionId&sortBy=abc"

file = File.open("test/example.html", "rb")
page_as_string = file.read

class PageParseManager
  attr_reader :rows, :parser

  def initialize(page_as_string)
    @parser = PageParser.new(page_as_string)
    @rows = parser.rows
  end

  def songs
    @songs ||= []
  end

  def turn_rows_into_songs
    rows.each do |row|
      row_parser = TableRowParser.new(row)

      song_info_hash = {title: row_parser.title,
                        url: row_parser.url,
                        artists: row_parser.artists,
                        tags: row_parser.tags}

      songs << SongInfo.new(song_info_hash)
    end
  end



end