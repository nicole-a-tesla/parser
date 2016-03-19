require 'pry'

class Collection
  attr_reader :title, :description, :sessions, :dir

  def initialize(info)
    @title = replace_whitespace(info[:title])
    @description = info[:description]
    @sessions = info[:sessions]
    @dir = info[:archive_dir] + @title + '/'
  end

  def build_self
    build_dir
    description_file = make_description_file[0]
    write_description_to_file(description_file)
  end

  def build_dir
    FileUtils.mkdir dir, mode: 0700
  end

  def make_description_file
    FileUtils.touch(dir + "description.txt")
  end

  def write_description_to_file(file_to_write_to)
    File.open(file_to_write_to, 'w') do |file|
      file.write(description)
    end
  end

  def replace_whitespace(text)
    text.gsub(/\s/, "_")
  end

end
