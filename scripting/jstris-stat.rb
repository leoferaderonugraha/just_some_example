require 'nokogiri'
require 'open-uri'
require 'pry'

page = open('https://jstris.jezevec10.com/u/rion')
doc = Nokogiri::HTML(page)
stat = Hash.new
#stat = Array.new

tables = doc.css('table')
tables[1].search('tr').each{|tr|
  cells = tr.search('th, td')
  map = {'<td>' => '', '<b>' => '', '</b>' => '', '</td>' => "\n"}
  regx = Regexp.union(map.keys)
  data = cells.to_s.gsub(regx, map).split("\n").reject{|c| c.empty?}
  stat.merge!(Hash[*data])
  #stat.append(data.each_slice(2).to_a)
  #puts cells.text  
  #binding.pry
}
stat.each{|key, val|
  #print key
  if key == "Games:"
    puts "#{key}\t\t\t#{val}"
  else
    puts "#{key}\t\t#{val}"
  end
}
#binding.pry

