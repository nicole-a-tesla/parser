require "net/http"
require_relative '../collection_parser'
require_relative '../session'

describe CollectionParser do
  file = File.open("test/example_collection.html", "rb")
  page_as_string = file.read
  let(:collection_parser) { CollectionParser.new(page_as_string, '/Users/bears8yourface/Documents/lomax2016/') }

  describe "title" do
    it "gets correct title" do
      expect(collection_parser.title).to eq "Mississippi Prison Recordings 1947 and 1948"
    end
  end

  describe "description" do
    it "gets the correct description" do
      expect(collection_parser.description).to eq "The Lomaxes and other collectors of their time (and also decades later) found some of the most powerful vernacular music of the American South in the region’s oppressive and violent prison system. The songs they found there, John and Alan Lomax wrote, “or songs like them were formerly sung all over the South. With the coming of the machines, however, the work gangs were broken up. The songs then followed group labor into its last retreat — the road gang and the penitentiary” (Our Singing Country, 1941). Bruce Jackson, writing about prison song in the 1960s, explains, “Southern agricultural penitentiaries were in many respects replicas of nineteenth-century plantations, where groups of slaves did arduous work by hand, supervised by white men with guns and constant threat of awful physical punishment. It is hardly surprising that the music of plantation culture — the work songs — went to the prisons as well.” The tie-tamping and wood-cutting chants, field hollers, and the occasional blues recorded by Alan Lomax on paper-backed tape at Mississippi’s Parchman Penitentiary in 1947 and 1948 remain among the most vivid documents of this genre of African American song.  "
    end
  end

  describe "sessions" do
    it "has a sessions collection of the correct size" do
      expect(collection_parser.sessions.size).to eq 2
    end

    let(:first_session) { collection_parser.sessions[0] }

    it "knows session's title" do
      expect(first_session.session_title).to eq "Parchman 12/47"
    end

    it "knows session's region" do
      expect(first_session.region).to eq "Mississippi, United States"
    end

    it "knows session's date" do
      expect(first_session.date).to eq "11-12/1947"
    end

    it "knows session's url" do
      expect(first_session.url).to eq "http://research.culturalequity.org/get-audio-ix.do?ix=recording&id=10268&idType=sessionId&sortBy=abc"
    end
  end

  let(:collection) { collection_parser.collection }

  it "builds a collection object" do
    expect(collection.class).to eq Collection
  end

  it "transfers formatted title" do
    expect(collection.title).to eq collection_parser.title.gsub(/\s/, "_")
  end

  it "transfers sessions" do
    expect(collection.sessions).to eq collection_parser.sessions
  end

  it "transfers description" do
    expect(collection.description).to eq collection_parser.description
  end

end
