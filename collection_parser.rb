require 'Nokogiri'
require 'pry'
require_relative 'collection'

class CollectionParser
  attr_reader :doc, :title, :description, :sessions, :collection, :archive_dir

  def initialize(page_string, archive_dir)
    @archive_dir = archive_dir
    @doc = Nokogiri::HTML(page_string)
    @title = get_title
    @description = get_description
    @sessions = get_sessions if collection_has_content

  end

  def collection_has_content
    doc.css("td.Bold")[0].text.strip != "Upcoming."
  end

  def collection
    @collection ||= build_collection
  end

  def build_collection
    if collection_has_content
      info = {title: title,
              description: description,
              sessions: sessions,
              archive_dir: archive_dir}
      @collection = Collection.new(info)
    end
    @collection
  end

  def get_title
    title = doc.css("h2.collectionHeader")[0].text
    replace_whitespace(title, "_")
  end

  def replace_whitespace(text, replacement)
    text.gsub(/\s/, replacement)
  end

  def get_description
    description = doc.css("p.collectionDesc")[0].next_element.text
    description.split(" ").join(" ").strip
  end

  def get_sessions
    raw_sessions = doc.css("tbody")[0].css("tr")

    sessions = raw_sessions.map do |session|
      session_info = session.css("td")

      info = {collection_title: title,
              # parent_collection_path: archive_dir +
              session_title: session_info[0].text,
              region: session_info[1].text,
              date: session_info[2].text,
              url: session_info[0].children[0].attributes["href"].value}
      SessionParser.new(info).build_session
    end
  end

end
