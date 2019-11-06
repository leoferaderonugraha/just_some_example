def animate(s)
  msg = s.split
  punc = [',', '.','/']
  last_ch = ''

  msg.each do |word|
    time = rand(0.08..0.15)
    word.chars.each do |c|
      
      if c == ';' # Newline
        print "\n"
      else
        
        if punc.include?(c)
          if c == ','
            print c
            sleep(0.3)
          else
            sleep(0.2)
            print c
            sleep(0.1)
          end
        else
          print c
          sleep(time)
        end

      end
      last_ch = c

    end
    #sleep(0.17)
    if last_ch != ';'
      print ' '
    end
  end
end

text = """
Teruntuk kamu, yang jauh di sana...;
Jagalah dirimu baik-baik...;
;
Dan selamat atas keberhasilanmu, kau telah bekerja keras untuk itu...;
Sekarang kau telah semakin dewasa, ku harap dirimu baik-baik saja di sana...;
;
Maafkan atas segala perbuatanku di masa lalu, dan hal-hal yang mungkin telah menyakitimu...;
Namun harus kau tahu, aku selalu berharap yang terbaik untukmu...;
;
Walau kita tak pernah bertemu, namun kau pernah mengisi relung hati ini...;
;
Akan tetapi, tak ada pertemuan tanpa adanya perpisahan...;
Dan ku harap ini bukanlah perpisahan kita, melainkan pertemuan kedua kita dalam pribadi yang;
lebih dewasa kelak...
;
Terimakasih telah menjadi bagian, dalam setiap kehidupan...;
;
Bandung, September/16/2019
"""

system('clear')
animate(text)
sleep(30)
