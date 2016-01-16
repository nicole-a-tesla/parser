require 'Nokogiri'
require 'pry'
require_relative 'table_row_parser'

class PageParser
  attr_reader :rows, :doc

  def initialize(string)
    # @doc = Nokogiri::HTML(open(url))
    @doc = Nokogiri::HTML(string)
    @rows = get_rows_array(@doc)
  end

  def get_rows_array(doc)
    children_of_tbody = @doc.css("tbody")[0].children
    table_rows = children_of_tbody.each_slice(3).to_a
    table_rows
  end

  def parse_rows(doc)

    table_rows.each do |song_row|
      # TableRowParser.new(song_row)
    end

 # tr.even/odd has the title and url
 # element 2 (no css) has the tags
 # elem 3 has the artist info
    rows_tagged_even = doc.css("tr.even")
    rows_tagged_odd = doc.css("tr.odd")
    rows_tagged_odd + rows_tagged_even

  end


end