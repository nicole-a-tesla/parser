require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative "table_row_parser"
require_relative "page_parser"
require_relative "song"


file = File.open("test/example.html", "rb")
page_as_string = file.read

class PageParseManager
  attr_reader :rows, :parser, :row_parser, :song, :pages_songs

  def initialize(args)
    @row_parser = args[:row_parser]
    @song = args[:song]
    @parser = args[:page_parser].new(args[:page_as_string])
    @rows = parser.rows
  end

  def pages_songs
    @pages_songs ||= []
  end

  def turn_rows_into_songs
    contains_no_useful_info = rows.pop
    rows.each do |row|
      row_parser = @row_parser.new(row)


      song_info_hash = {title: row_parser.title,
                        url: row_parser.url,
                        artists: row_parser.artists,
                        tags: row_parser.tags}

      pages_songs << song.new(song_info_hash)
    end
  end



end