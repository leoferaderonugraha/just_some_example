#!/usr/bin/env ruby

require 'discordrb'
require 'httparty'
require 'pry'
require 'nokogiri'
require 'mechanize'
require 'open-uri'
require 'socket'
require 'open3'

bot_info = Hash.new
bot_info['token'] = 'NjAwMTM2MjE0NTMxNjcwMDI4.XS62gw.CHgyZNV_GNuvYg0q9_huyJrA6uI'
bot_info['client_id'] = 600136214531670028

bot = Discordrb::Commands::CommandBot.new(token: bot_info['token'],
                                          client_id: bot_info['client_id'],
                                          prefix: '$')

emojis = Hash.new
emojis['love'] = "\xE2\x9D\xA4"
emojis['blush'] = "\xF0\x9F\x98\x8A"
emojis['grin'] = "\xF0\x9F\x98\x81"
emojis['wink'] = "\xF0\x9F\x98\x89"
emojis['angry'] = "\xF0\x9F\x98\xA0"
emojis['red angry'] = "\xF0\x9F\x98\xA1"
emojis['tear'] = "\xF0\x9F\x98\xA2"

bot.command(:who) {|event|
  event.respond("im your baby #{emojis['love']}") # or reply with 'event <<' or just return it
}

bot.command(:ping) {|event|
  'pong!'
}

bot.command(:testargs) {|event|
  args = event.message.content.split(' ')
  event << args.to_s
}

bot.command(:goodjob) {|event|
  "Thank You #{emojis['blush']}"
}

bot.command(:connect) {|event|
  channel = event.user.voice_channel
  next "You're not in any voice channel!" unless channel

  bot.voice_connect(channel)
  "Connected to voice channel: #{channel.name}"
}

#bot.command(:play){|event|
#  music_dir = "/run/media/rion/68A4B510A4B4E22C/Users/rion/Music/"
#  voice_bot = event.voice
#  voice_bot.play_file("#{music_dir}01 Bohemian Rhapsody.mp3")
#}

bot.command(:random){|event, min, max|
  rand(min.to_i..max.to_i)
}

bot.command(:react){|event|
  event.respond bot.emoji[rand(0...bot.emoji.size)].use
}

bot.command(:loop){|event, count|
  (0..count.to_i).each{|x|
    event << x
  }
  nil
}

bot.command(:online){|event|
  #binding.pry
  bot.users.each{|key, val|
    event.respond bot.users[key].distinct if !bot.users[key].bot_account? && bot.users[key].online?
  }
  nil
}

bot.command(:d){|event|
  sum = event.message.content.split(' ')
  sum.shift
  event.respond eval(sum.join)
}

#bot.command(:debug){ |event|
#  binding.pry
#}

#Featured
bot.command([:lyric, :l]){ |event|
  argv = event.message.content.split(' ')
  argv.shift
  uri = "https://www.bing.com/search?q=#{argv.join('+')}+site:genius.com"
  links = []
  data = []
  mech = Mechanize.new
  mech.redirect_ok = true
  mech.user_agent = 'Mozilla/5.0 (Windows NT 5.1; rv:7.0.1) Gecko/20100101 Firefox/7.0.1'

  mech.get(uri)
  doc = Nokogiri::HTML(mech.page.body)
  doc.css('li.b_algo a').each{|link| links.append(link['href'])} #extract all links
  mech.get(links[0])  #open the first link
  doc = Nokogiri::HTML(mech.page.body) #parse
  doc.css('p').each {|x| data << x.content} #extract data between elements
  #binding.pry
  if data[0].length <= 2000
    event << "**" + doc.css('title').text + "**" #extract data between <title></title> and make it bold
    event << "```md"
    event << data[0]
    event << "`requested by: #{event.user.display_name}`"
  else
    event.respond "**" + doc.css('title').text + "**"
    parsed = data[0].split("\n\n")
    event.respond "```"+parsed[0...parsed.size/2].join("\n\n")+"```"
    event.respond "```"+parsed[parsed.size/2...parsed.size].join("\n\n")+"```"
    event.respond "`requested by: #{event.user.display_name}`"
    #event.respond "Sorry, the message was too heavy for me to sent. #{emojis['tear']}"
  end
}

bot.command(:insta){|event, username|
  data = ''
  doc = Nokogiri::HTML(open("https://www.instagram.com/#{username}/").read)
  doc.css('meta[property="og:description"]').map{|x| data << x['content']}
  data = data.split(',')
  event << "```css\nCurrently have: #{data[0]} and #{data[1]}\n```"
}

bot.command(:qotd){|event|
  s = TCPSocket.open('djxmmx.net', 17)
  event << '`'
  while line = s.gets
    event << line.strip
  end
  event << '`'
  s.close
}

bot.command(:tellmefact){|event|
  facts = ['funny','lame','retarded','gay', 'nice', 'absurd', 'cool', 'jerk', 'have dirty mind', 'hot', 'sexy', 'bad guy', 'stinky', "jomblo #{emojis['tear']}"]
  event.respond("You are actually ||"+facts[rand(0...facts.size)]+"||.")
}

bot.command(:jstris){|event, username|
  page = open("https://jstris.jezevec10.com/u/#{username}")
  doc = Nokogiri::HTML(page)
  #stat = Hash.new
  stat = Array.new
  
  tables = doc.css('table')
  tables[1].search('tr').each{|tr|
    cells = tr.search('th, td')
    map = {'<td>' => '', '<b>' => '', '</b>' => '', '</td>' => "\n"}
    regx = Regexp.union(map.keys)
    data = cells.to_s.gsub(regx, map).split("\n").reject{|c| c.empty?}
    #stat.merge!(Hash[*data])
    stat.append(data.each_slice(2).to_a)
    #puts cells.text  
    #binding.pry
  }
  stat = stat.flatten.each_slice(2).to_a
  stat[0][0] = stat[0][0]+" "*16  #Game
  stat[1][0] = stat[1][0]+" "*13  #Max Apm
  stat[2][0] = stat[2][0]+" "*11  #Total time
  stat[3][0] = stat[3][0]+" "*11  #Max Combo
  stat[4][0] = stat[4][0]+" "*11  #Lines sent
  stat[5][0] = stat[5][0]+" "*9  #Longest game
  stat[6][0] = stat[6][0]+" "*7   #Lines received
  stat[7][0] = stat[7][0]+" "*11  #Total B2Bs
  stat[8][0] = stat[8][0]+" "*8   #Placed blocks
  stat[9][0] = stat[9][0]+" "*12  #Most sent
  stat[10][0] = stat[10][0]+" "*9 #10-games APM
  stat[11][0] = stat[11][0]+" "*9 #10-games PPS

  event << "```"
  stat.each{|key, val|
    event << "#{key}\t#{val}"
  }
  event << "```"

}

#IoT
bot.command(:whois){|event, domain|
  url = "https://madchecker.com/domain/api/#{domain}?"\
        "properties=expiration-creation-registrant_email-"\
        "registrant_name-registrant_organization"
  data = JSON.parse(HTTParty.get(url))
  
  if data.to_a[1][0] == 'error'
    data['error']
  else
    event << "Domain: #{data['domain']}\n"
    event << "Available: #{data['data']['available'] == true ? 'yes' : 'no'}"
    event << "Creation: #{data['data']['creation']}"
    event << "Expiration: #{data['data']['expiration']}"
    event << "Registrant Email: #{data['data']['registrant_email']}"
    event << "Registrant Name: #{data['data']['registrant_name']}"
    event << "Registrant Organization: #{data['data']['registrant_organization']}"
  end
  #stdout, stderr, status = Open3.capture3('whois', domain)
  #if status.success?
  #  event.respond stdout.split('>>>')[0]
  #else
  #  event.respond "An error occured."
  #end
}
bot.command(:geoip) {|event, host|
  api_key = "e27e067ff86e4e81bd769aac1187a6fa"
  data = JSON.parse(open("http://api.ipstack.com/#{host}?access_key=#{api_key}&format=1").read)
  event << "```pascal"
  event << "IP:#{' '*12}#{data['ip']}"
  event << "Type:#{' '*10}#{data['type']}"
  event << "Continent:#{' '*5}#{data['continent_name']}"
  event << "Country:#{' '*7}#{data['country_name']} #{data['location']['country_flag_emoji']}"
  event << "Capital:#{' '*7}#{data['location']['capital']}"
  event << "City:#{' '*10}#{data['city']}"
  event << "ZIP:#{' '*11}#{data['zip']}"
  event << "Region Name:#{' '*3}#{data['region_name']}"
  event << "Latitude:#{' '*6}#{data['latitude']}"
  event << "Longitude:#{' '*5}#{data['longitude']}"
  event << "Calling Code:#{' '*2}#{data['location']['calling_code']}"
  event << "```"
  #binding.pry
}


begin
  bot.run
rescue Interrupt
  puts "Shutting Down..."
  exit
rescue Exception => e
  raise e
end
