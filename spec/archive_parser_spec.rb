require_relative '../archive_parser'
require 'fileutils'
require 'pry'

describe ArchiveParser do
  let(:arch_parser) { ArchiveParser.new }
  let(:arch_parser_dir) { '/Users/bears8yourface/Documents/lomax2016/' }
  let(:urls) { [
      "http://research.culturalequity.org/get-audio-ix.do?ix=session&id=CC46&idType=abbrev&sortBy=abc",
      "http://research.culturalequity.org/get-audio-ix.do?ix=session&id=GS46&idType=abbrev&sortBy=abc",
      "http://research.culturalequity.org/get-audio-ix.do?ix=session&id=BI47&idType=abbrev&sortBy=abc",
      "http://research.culturalequity.org/get-audio-ix.do?ix=session&id=PR47&idType=abbrev&sortBy=abc",
      "http://research.culturalequity.org/get-audio-ix.do?ix=session&id=CR48&idType=abbrev&sortBy=abc",
      "http://research.culturalequity.org/get-audio-ix.do?ix=session&id=VH48&idType=abbrev&sortBy=abc",
      "http://research.culturalequity.org/get-audio-ix.do?ix=session&id=JI49&idType=abbrev&sortBy=abc",
      "http://research.culturalequity.org/get-audio-ix.do?ix=session&id=JR49&idType=abbrev&sortBy=abc",
      "http://research.culturalequity.org/get-audio-ix.do?ix=session&id=EN51&idType=abbrev&sortBy=abc",
      "http://research.culturalequity.org/get-audio-ix.do?ix=session&id=IR51&idType=abbrev&sortBy=abc",
      "http://research.culturalequity.org/get-audio-ix.do?ix=session&id=SC51&idType=abbrev&sortBy=abc",
      "http://research.culturalequity.org/get-audio-ix.do?ix=session&id=BB52&idType=abbrev&sortBy=abc",
      "http://research.culturalequity.org/get-audio-ix.do?ix=session&id=SP52&idType=abbrev&sortBy=abc",
      "http://research.culturalequity.org/get-audio-ix.do?ix=session&id=7&idType=abbrev&sortBy=abc",
      "http://research.culturalequity.org/get-audio-ix.do?ix=session&id=SJ59&idType=abbrev&sortBy=abc",
      "http://research.culturalequity.org/get-audio-ix.do?ix=session&id=HW60&idType=abbrev&sortBy=abc",
      "http://research.culturalequity.org/get-audio-ix.do?ix=session&id=BJ61&idType=abbrev&sortBy=abc",
      "http://research.culturalequity.org/get-audio-ix.do?ix=session&id=CA62&idType=abbrev&sortBy=abc",
      "http://research.culturalequity.org/get-audio-ix.do?ix=session&id=RM64&idType=abbrev&sortBy=abc",
      "http://research.culturalequity.org/get-audio-ix.do?ix=session&id=SU64&idType=abbrev&sortBy=abc",
      "http://research.culturalequity.org/get-audio-ix.do?ix=session&id=CP65&idType=abbrev&sortBy=abc",
      "http://research.culturalequity.org/get-audio-ix.do?ix=session&id=NF66&idType=abbrev&sortBy=abc",
      "http://research.culturalequity.org/get-audio-ix.do?ix=session&id=DS67&idType=abbrev&sortBy=abc",
      "http://research.culturalequity.org/get-audio-ix.do?ix=session&id=7&idType=abbrev&sortBy=abc",
      "http://research.culturalequity.org/get-audio-ix.do?ix=session&id=MISC&idType=abbrev&sortBy=abc",
    ] }

  xit "gets collection urls" do
    expect(arch_parser.collection_urls).to eq urls
  end

  xit "builds correct # of collection objects" do
    collections = arch_parser.build_collections(urls)
    expect(collections.size).to eq urls.size
  end

  it "builds a lomax folder" do
    arch_parser.build_dir
    expect(Dir.exist?(arch_parser_dir)).to eq true
    FileUtils.rm_rf(arch_parser_dir)
  end
end
