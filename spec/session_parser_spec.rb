require_relative '../session_parser'

describe SessionParser do
  it "ends up with the right number of songs" do
    info = {
      url: "get-audio-ix.do?ix=recording&id=10270&idType=sessionId&sortBy=abc",
    }

    s = SessionParser.new(info)
    s.parse
    expect(s.songs.size).to eq 59
  end
end
