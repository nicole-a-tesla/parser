require_relative '../session_parser'

describe SessionParser do
  let(:info) {
    {
      url: "get-audio-ix.do?ix=recording&id=10270&idType=sessionId&sortBy=abc",
      session_title: "Session Title",
      collection_title: "Collection Title",
      region: "region name",
      date: "1/1/1111"
    } }

  it "ends up with the right number of songs" do
    s = SessionParser.new(info)
    s.parse_songs
    expect(s.songs.size).to eq 59
  end

  it "builds Session with correct title" do
    session = SessionParser.new(info).build_session
    expect(session.session_title).to eq info[:session_title]
  end

  it "builds Session with correct collection_title" do
    session = SessionParser.new(info).build_session
    expect(session.collection_title).to eq info[:collection_title]
  end

  it "builds Session with correct region" do
    session = SessionParser.new(info).build_session
    expect(session.region).to eq info[:region]
  end

  it "builds Session with correct date" do
    session = SessionParser.new(info).build_session
    expect(session.date).to eq info[:date]
  end

  it "builds Session with correct songs" do
    session_parser = SessionParser.new(info)
    session = session_parser.build_session
    expect(session.songs).to eq session_parser.songs
  end
end
