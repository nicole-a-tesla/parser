require_relative '../collection'
require 'fileutils'
require 'pry'

describe Collection do
  let(:args) { {title: "This is a title",
            description: "This is a description",
            sessions: [],
            archive_dir: '/Users/bears8yourface/Documents/lomax2016/'} }
  let(:collection) { Collection.new(args) }

  it "formats dir-name-friendly title" do
    expect(collection.title).to eq "This_is_a_title"
  end

  it "builds a dir at archive_dir/<collection_title>" do
    FileUtils.mkdir args[:archive_dir], mode: 0700

    collection.build_dir

    expect(Dir.exist?('/Users/bears8yourface/Documents/lomax2016/' + collection.title)).to eq true

    FileUtils.rm_rf(args[:archive_dir])
  end

  it "creates text file for description" do
    FileUtils.mkdir args[:archive_dir], mode: 0700
    collection.build_dir

    collection.make_description_file

    expect(File.exists?(collection.dir + '/description.txt')).to eq true
    FileUtils.rm_rf(args[:archive_dir])
  end

  it "writes description to description.txt" do
    FileUtils.mkdir args[:archive_dir], mode: 0700
    collection.build_dir
    desc_file = collection.make_description_file[0]

    collection.write_description_to_file(desc_file)
    file_text = IO.read(collection.dir + '/description.txt')
    expect(file_text).to eq args[:description]

    FileUtils.rm_rf(args[:archive_dir])
  end

  it "build_self does all of the above" do
    FileUtils.mkdir args[:archive_dir], mode: 0700
    collection.build_self

    file_text = IO.read(collection.dir + '/description.txt')
    expect(file_text).to eq args[:description]

    FileUtils.rm_rf(args[:archive_dir])
  end

  after (:all) do
    FileUtils.rm_rf("/Users/bears8yourface/Documents/lomax2016/")
  end

end
