require "nokogiri"
require "open-uri"
require "net/http"
require "pry"

require_relative 'page_parse_manager'
require_relative 'session'

class SessionParser
  attr_reader :session_title, :collection_title, :parent_collection_path, :region, :date, :url, :songs
  BASE_URL = "http://research.culturalequity.org/"

  def initialize(info)
    @session_title = info[:session_title] || "Unknown"
    @collection_title = info[:collection_title] || "Unknown_collection"
    @parent_collection_path = info[:parent_collection_path]
    @region = info[:region] || "Unknown"
    @date = info[:date] || "Unknown"
    @url = BASE_URL + info[:url] if info[:url]
    @songs = []
  end

  def build_session
    session_args = {
      session_title: session_title,
      collection_title: collection_title,
      parent_collection_path: parent_collection_path,
      region: region,
      date: date,
      url: url,
      songs: parse_songs
    }
    Session.new(session_args)
  end

  def parse_songs
    page_urls = get_all_urls

    page_urls.each do |page_url|
      puts ""
      puts page_url

      response = Net::HTTP.get_response(URI.parse(page_url))
      doc = Nokogiri::HTML(response.body)

      parse_manager = PageParseManager.new({page_as_string: response.body})
      songs << parse_manager.pages_songs
    end
    songs.flatten!
  end

  def get_all_urls
    doc = get_nokogiri_HTML_from_url(url)
    pages_nav_bar = doc.css("td.pageNumberTD")[0]

    if not pages_nav_bar 
        return [url]
    end

    p = pages_nav_bar.xpath("a").map do |node|
      BASE_URL + node["href"] if node.text == node.text.to_i.to_s
    end.compact!

    p.unshift(@url)
  end

  def get_nokogiri_HTML_from_url(url)
    response = Net::HTTP.get_response(URI.parse(url))
    Nokogiri::HTML(response.body)
  end

end
