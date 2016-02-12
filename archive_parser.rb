require 'pry'
require 'open-uri'
require 'net/http'
require 'nokogiri'

require_relative "collection_parser"
require_relative "session"

# take as arg url oc collections page
# foreach collection:
  # create a collection parser
  # get the collection it builds
  # create a folder for that collection (title)
  # create txt file for text data
  # foreach session in collection :
    # create subfolder for the session (title)
    # create a txt file for text data
    # navigate to url
    # foreach page of session
      # create new PageParseManager/parser
      # parse to rows
      # foreach row :
        # write row into a new mp3, plus metadata
class ArchiveParser

  URL = "http://research.culturalequity.org/audio-guide.jsp"
  BASE_URL = "http://research.culturalequity.org/"

  def initialize

  end

  def collections
    @collections ||= []
  end

  def get_collection_urls
    response = Net::HTTP.get_response(URI.parse(URL))
    noko_page = Nokogiri::HTML(response.body)

    raw_collections = noko_page.css("td.audioGuideLink")

    # get collection urls
    @collection_urls = raw_collections.map do |collection|
      collection_url = collection.children[1].attributes["href"].value
      base_url + collection_url
    end
  end

  def build_collections

    # build collections
    collections = @collection_urls.map do |collection_url|
      response = Net::HTTP.get_response(URI.parse(collection_url))
      page_as_string = response.body

      CollectionParser.new(page_as_string).build_collection
    end
  end

end




# collections.each do |collection|
#   # make a folder
#   collection.sessions.each do |session|
#     # make a folder
#     session.parse
#   end
# end
