puts '[1: Rock, 2: Paper, 3: Scissor]'
print 'What\'s your choice: '

u_choice = gets.chomp.to_i
bot_choice = rand(0...3) #gets.chomp.to_i 
result = u_choice - bot_choice

choices = ['Rock','Paper','Scissor']

puts "Your: #{choices[u_choice-1]}\nBot: #{choices[bot_choice-1]}"

case result
when 0
  puts 'Draw'
when 1, -2
  puts 'User Win'
when 2,-1
  puts 'Bot Win'
else
  puts 'Error'
end
