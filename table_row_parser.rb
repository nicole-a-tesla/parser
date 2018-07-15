require 'pry'

class TableRowParser
  attr_reader :title, :url, :artists, :tags

  def initialize(row_element_array)
    @title = build_title(row_element_array)
    @url = parse_for_url(row_element_array)
    @artists = parse_for_artists(row_element_array)
    @tags = parse_for_tags(row_element_array)
  end

  def build_title(row_element_array)
    title_is_here = row_element_array[1]
    title_text = title_is_here.text

    who_knows_what_encoding = title_text.strip()
    stripped = who_knows_what_encoding.encode("UTF-8", invalid: :replace, undef: :replace)

    final = stripped.gsub(/\s/, "_")
    puts final 
    final
  end

  def parse_for_url(row_element_array)
    row_element_array[1].children[7].children.children.children[0].attributes["href"].value
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
