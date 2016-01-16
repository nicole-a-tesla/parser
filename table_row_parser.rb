require 'pry'

class TableRowParser
  attr_reader :title, :url, :artists, :tags

  def initialize(row_element_array)
    # binding.pry
    @title = build_title(row_element_array[1].text.strip())
    @url = parse_for_url(row_element_array[1])
    @artists = parse_for_artists(row_element_array)
    @tags = parse_for_tags(row_element_array)
  end

  def build_title(title_string)
    title_string.gsub(/\s/, "_")
  end

  def parse_for_url(row_element)
    row_element.children[7].children.children.children[0].attributes["href"].value
  end

  def parse_for_tags(row_element_array)
    potential_tag_objects = row_element_array[2].css("td.subtableTD")[0].children

    parse_td_subtables_for_nonempty_strings(potential_tag_objects)
  end

  def parse_for_artists(row_element_array)
    potential_artist_objects = row_element_array[2].css("td.subtableTD")[1].children

    parse_td_subtables_for_nonempty_strings(potential_artist_objects)
  end

  def parse_td_subtables_for_nonempty_strings(collection)
    collection.each_with_object([]) do |obj, nonempties|
      maybe_has_content = obj.children.text

      nonempties << maybe_has_content if maybe_has_content != ""
    end
  end


end