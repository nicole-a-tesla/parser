require 'fileutils'

class Session
  attr_accessor :session_title, :collection_title, :region, :date, :url, :songs, :parent_collection_path
  def initialize(args)
    @session_title = args[:session_title]
    @collection_title = args[:collection_title]
    @region = args[:region]
    @date = args[:date]
    @url = args[:url]
    @songs = args[:songs]
    @parent_collection_path = args[:parent_collection_path]
  end

  def build_self
    build_dir
    data_file = build_data_file[0]
    write_to_data_file(data_file)
  end

  def get_session_path
    parent_collection_path + session_title + "/"
  end

  def build_dir
    FileUtils.mkdir get_session_path, mode: 0700
  end

  def build_data_file
    FileUtils.touch(get_session_path + "session_data.txt")
  end

  def write_to_data_file(file_to_write_to)
    File.open(file_to_write_to, "w") do |file|
      file.write(region)
      file.write("\n")
      file.write(date)
    end
  end

end
