require 'open-uri'
require 'net/http'

url = 'http://c0383352.cdn.cloudfiles.rackspacecloud.com/audio/T1700R15.mp3'

# open('test_save.mp3', 'w') do |file|
#   file << open().read
# end

res = Net::HTTP.get_response(URI.parse(url))

File.open('test_save.mp3','w') do |f|
  f.write(res.body)
end