require 'colorize'

def welcome
  system 'clear'
  puts "WELCOME TO JAMASTERMIND!".black.on_yellow.bold.center(100)

  puts ''

  puts "Test your code-cracking hability with #{'JaMastermind'.black.on_yellow.bold}, a game of\nlogic and deduction"
  puts "Play against the computer to see who's got the codebraking \nskills that matches no one!"
  puts ''
  puts "You can be either the #{'Codemaker'.colorize(:green)} that sets a secret code, or \nthe #{'Codebreaker'.colorize(:blue)}, who tries to match the code using logic, \ndeduction, and maybe even a little bit of luck."
  puts ''
  puts "Take turns trying to figure out the computer's code, or \nsetting a sequence that it won't ever break!"
  puts "After each move, the #{'Codemaker'.colorize(:green)} gives clues to the \n#{'Codebreaker'.colorize(:blue)}. Make the code even more devious by using \nmultiple different numbers, from 1 to 6!" 
  puts ''
  puts "With so many possible code combinations, every game \nis guaranteed to be a brainteaser!"
end

def main_menu_message
  puts ''
  puts "Please type:"
  puts ''
  puts "#{'1)'.bold} to start"
  puts "#{'2)'.bold} to exit"
  return choice = gets.chomp
end

def start_msg
  system 'clear'
  puts "STARTING JAMASTERMIND.".black.on_yellow.bold
  sleep (0.5)
  system 'clear'
  puts "STARTING JAMASTERMIND..".black.on_yellow.bold
  sleep (0.5)
  system 'clear'
  puts "STARTING JAMASTERMIND...".black.on_yellow.bold
  sleep (0.5)
  system 'clear'
  puts "STARTING JAMASTERMIND....".black.on_yellow.bold
  sleep (0.5)
  system 'clear'
  puts "STARTING JAMASTERMIND.....".black.on_yellow.bold
  sleep (0.5)
  system 'clear'
  puts "STARTING JAMASTERMIND......".black.on_yellow.bold
  sleep (0.5)
end

def human_turn_text
  puts "#{'CODEMAKER'.colorize(:green)}: #{'Computer'.underline}"
  sleep(1)
  puts "#{'CODEBREAKER'.colorize(:blue)}: #{'Human'.underline}"
  sleep(1)
  puts ''
  puts "Code created."
end

def computer_turn_text
  puts "#{'CODEMAKER'.colorize(:green)}: #{'Human'.underline}"
  #sleep(1)
  puts "#{'CODEBREAKER'.colorize(:blue)}: #{'Computer'.underline}"
  #sleep(1)
  puts ''
end