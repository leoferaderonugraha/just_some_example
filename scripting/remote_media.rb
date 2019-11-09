require 'socket'

key_map = {
  'play' => 'xdotool key XF86AudioPlay',
  'prev' => 'xdotool key XF86AudioPrev',
  'next' => 'xdotool key XF86AudioNext'
}

server = TCPServer.new(2000)

loop do
  # Make a thread(s) so we can
  # accept multiple connections
  Thread.start(server.accept) do |client|
    puts 'Connected!'
    
    client.puts('Hello there')
    client.puts("Current time is: #{Time.now}")
    
    loop do
      begin
        msg = client.recv(1024).chomp
        if !msg.nil?
          if !key_map[msg].nil?
            system(key_map[msg])
          end
          puts "recv -> #{msg.inspect}"
        else
          puts 'empty'
        end
      rescue Errno::ECONNRESET
        puts "Connection ended\n"
        puts 'Closing program...'
        break
      end
    end

    client.close
    #exit(0)
  end
end
