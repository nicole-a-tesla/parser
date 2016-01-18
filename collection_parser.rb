require 'Nokogiri'
require 'pry'

class CollectionParser
  # input url (?) / text of collection page
  # each sub-collection has session_title, region, and date
  # output : navigate through collection, creating new parse_manager for each page_string

  attr_reader :doc, :title, :description, :sessions

  def initialize(page_string)
    @doc = Nokogiri::HTML(page_string)
    @title = get_title
    @description = get_description
    @sessions = get_sessions
  end

  def get_title
    doc.css("h2.collectionHeader")[0].text
  end

  def get_description
    description = doc.css("p.collectionDesc")[0].next_element.text
    description.split(" ").join(" ").strip
  end

  def get_sessions
    raw_sessions = doc.css("tbody")[0].css("tr")

    sessions = raw_sessions.map do |session|
      session_info = session.css("td")

      info = {session_title: session_info[0].text,
              region: session_info[1].text,
              date: session_info[2].text,
              url: session_info[0].children[0].attributes["href"].value}
      Session.new(info)
    end

  end

end

# Collection: "Mississippi Prison Recordings 1947 and 1948"
#   Description: "..."
#   Sessions: title: "Parchman 12/47",
#             region: "...",
#             date: "11-x-19xx"