class Collection
  attr_reader :title, :description, :sessions

  def initialize(info)
    @title = info[:title]
    @description = info[:description]
    @sessions = info[:sessions]
  end

end
