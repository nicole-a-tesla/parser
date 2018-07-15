require 'pry'
require 'open-uri'
require 'net/http'
require 'nokogiri'

require_relative "collection_parser"
require_relative "session_parser"

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
  attr_reader :collection_urls, :collections, :archive_path

  URL = "http://research.culturalequity.org/audio-guide.jsp"
  BASE_URL = "http://research.culturalequity.org/"
  MOTHER_DIR = '/lomax'

  def initialize(archive_directory_name)
    @archive_path = MOTHER_DIR + "/" + archive_directory_name
  end

  def build_dir
    FileUtils.mkdir archive_path, mode: 0700
    return archive_path
  end

  def parse
    build_dir
    @collection_urls = get_collection_urls
    @collections = build_collections(@collection_urls)
    @collections
  end

  def collection_urls
    @collection_urls || get_collection_urls
  end

  def get_collection_urls
    response = Net::HTTP.get_response(URI.parse(URL))
    noko_page = Nokogiri::HTML(response.body)

    raw_collections = noko_page.css("td.audioGuideLink")

    @collection_urls = raw_collections.map do |collection|
      collection_url = collection.children[1].attributes["href"].value
      BASE_URL + collection_url
    end
  end

  def build_collections(urls)
    @collections = urls.map do |collection_url|
      response = Net::HTTP.get_response(URI.parse(collection_url))
      page_as_string = response.body

      CollectionParser.new(page_as_string, archive_path).build_collection
    end
  end

end
