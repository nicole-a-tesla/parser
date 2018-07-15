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
    collection = @doc.css("tbody")
    if collection.length 
        first_thing = collection[0]
        if first_thing
            children_of_tbody = first_thing.children
            table_rows = children_of_tbody.each_slice(3).to_a
            return table_rows
        end
    end
    puts ""
    puts "ROWS ARRAY WAS EMPTY! COLLECTION = "
    puts collection
    puts ""

    return []
  end

end
