require_relative '../session'

describe Session do
  it "ends up with the right number of songs" do
    info = {
      url: "get-audio-ix.do?ix=recording&id=10270&idType=sessionId&sortBy=abc",
    }

    s = Session.new(info)
    s.parse
    expect(s.songs.size).to eq 59
  end
end