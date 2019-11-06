require 'nokogiri'
require 'open-uri'

if ARGV.length != 1
  abort("Usage #{__FILE__} [username]")
end

data = ''
doc = Nokogiri::HTML(open("https://www.instagram.com/#{ARGV.shift}/").read)
doc.css('meta[property="og:description"]').map{ |x| data << x['content'] }

#puts doc
data = data.split(',')
puts "Currently have: #{data[0]} and #{data[1]}"
#print data
