require 'nokogiri'
require 'pry'
require_relative 'table_row_parser'

class PageParser
  attr_reader :rows, :doc

  def initialize(string)
    @doc = Nokogiri::HTML(string)
    @rows = get_rows_array(@doc)
  end

  def get_rows_array(doc)
    children_of_tbody = @doc.css("tbody")[0].children
    table_rows = children_of_tbody.each_slice(3).to_a
    table_rows
  end

end
