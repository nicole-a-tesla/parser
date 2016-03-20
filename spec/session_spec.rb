require_relative '../session'

describe Session do
  BASE_DIR = '/Users/bears8yourface/Documents/lomax_test/'
  let(:args) { {
      collection_title: "collection_title",
      parent_collection_path: BASE_DIR + "/" + "collection_title" + "/",
      session_title: "session_title",
      region: "region name",
      date: "1/2/3456",
      url: "http://url.com"
    } }
  let(:session) { Session.new(args) }
  let(:parent_path) { args[:parent_collection_path] }
  let(:expected_session_path) { parent_path + args[:session_title] + "/" }

  before(:each) do
    FileUtils.mkdir BASE_DIR, mode: 0700
    FileUtils.mkdir parent_path, mode: 0700
  end

  it "builds a Session dir" do
    session.build_dir
    expect(File.exists?(expected_session_path)).to eq true
  end

  it "creates txt file for region and date data" do
    session.build_dir
    session.build_data_file
    expect(File.exists?(expected_session_path + "session_data.txt")).to eq true
  end

  it "writes the region and date to the session data text file" do
    session.build_dir
    data_file = session.build_data_file[0]
    session.write_to_data_file(data_file)

    file_text = IO.read(expected_session_path + "session_data.txt")

    expect(file_text).to eq("region name\n1/2/3456")

  end

  after(:each) do
    FileUtils.rm_rf("/Users/bears8yourface/Documents/lomax_test/")
  end
end
