require_relative '../collection'
require 'fileutils'
require 'pry'

describe Collection do
  let(:args) { {title: "This_is_a_title",
            description: "This is a description",
            sessions: [],
            archive_dir: '/Users/bears8yourface/Documents/lomax2016/'} }
  let(:collection) { Collection.new(args) }
  let(:description_path) { args[:archive_dir] + args[:title] + '/description.txt' }

  it "has correct title" do
    expect(collection.title).to eq args[:title]
  end

  it "builds a dir at archive_dir/<collection_title>" do
    FileUtils.mkdir args[:archive_dir], mode: 0700
    collection.build_dir
    expect(Dir.exist?(args[:archive_dir] + collection.title)).to eq true
  end

  it "creates text file for description" do
    FileUtils.mkdir args[:archive_dir], mode: 0700
    collection.build_dir

    collection.make_description_file
    expect(File.exists?(description_path)).to eq true
  end

  it "writes description to description.txt" do
    FileUtils.mkdir args[:archive_dir], mode: 0700
    collection.build_dir
    desc_file = collection.make_description_file[0]

    collection.write_description_to_file(desc_file)
    file_text = IO.read(description_path)
    expect(file_text).to eq args[:description]
  end

  it "build_self does all of the above" do
    FileUtils.mkdir args[:archive_dir], mode: 0700
    collection.build_self

    file_text = IO.read(description_path)
    expect(file_text).to eq args[:description]
  end

  after (:each) do
    FileUtils.rm_rf("/Users/bears8yourface/Documents/lomax2016/")
  end

end
