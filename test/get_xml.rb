require 'open-uri'
require 'net/http'
require 'pry'

# url = "http://research.culturalequity.org/get-audio-ix.do?ix=recording&id=10500&idType=sessionId&sortBy=abc"

# response = Net::HTTP.get_response(URI.parse(url))
# body = response.body

# File.open('example.html','w') do |f|
#   f.write(body)
# end

url = "http://research.culturalequity.org/get-audio-ix.do?ix=session&id=PR47&idType=abbrev&sortBy=abc"

response = Net::HTTP.get_response(URI.parse(url))

body = response.body

File.open('collection_example.html', 'w') do |f|
  f.write("HELLO")
end