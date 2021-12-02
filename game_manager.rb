require_relative 'answer'
require_relative 'messages'

include Answer

@guess = ''
@answer = ''
@correct = false
@human_turn = false
@computer_turn = false
@human_score = 0
@computer_score = 0

def getGuess
  @guess
end

def getAnswer
  @answer
end

def getCorrect
  @correct
end

def main_menu
  #welcome
  choice = main_menu_message
  menu_selection(choice)
end

def menu_selection(choice)
  if choice.to_i == 1
    start
  elsif choice.to_i == 2
    puts 'exit'
  else
    puts ''
    puts "Wrong input."
    new_choice = main_menu_message
    menu_selection(new_choice)
  end
end

def define_answer
  puts "Create a code 4 numbers long, from 1 to 6:"
  new_answer = gets.chomp
  if new_answer.length != 4
    puts "Your number should be 4 characters long."
    define_answer
  elsif new_answer =~ /0+|[7-9]+/
    puts "All characters must be between 1 and 6."
    define_answer
  else
    return new_answer.chars
  end
end

def human_turn
  @answer = new_answer
  @human_turn = true
  @computer_turn = false

  human_turn_text
  puts ""
  sleep (2)
  system 'clear'

  guesses = 0  
  while guesses < 10
    puts "#{'Remaining guesses:'.bold} #{10-guesses}"
    @guess = make_guess
    compare_answer(@guess, @answer)
    break if @correct == true
    guesses += 1
  end
  
  return guesses
end

def computer_turn
  @human_turn = false
  @computer_turn = true

  system 'clear'
  computer_turn_text
  @answer = define_answer

  puts ""
  sleep (2)
  system 'clear'

  guesses = 0  
  while guesses < 10
    puts "#{'Remaining guesses:'.bold} #{10-guesses}"
    @guess = 
    compare_answer(@guess, @answer)
    break if @correct == true
    guesses += 1
  end
  
  return guesses
end

def start_round
  puts "#{'Scoreboard'.colorize(:red).bold}:"
  puts "#{'Human'.bold}: #{@human_score}"
  puts "#{'Computer'.bold}: #{@computer_score}"
  puts ''
  sleep(1)

  h_turns = human_turn
  puts "You guessed in #{h_turns} turns."

  sleep(2)

  c_turns = computer_turn
  puts "You guessed in #{c_turns} turns."
end

def start
  #start_msg
  puts ''
  start_round
end

def make_guess
  puts "Type in a number 4 characters long, from 1 to 6:"
  new_guess = gets.chomp
  if new_guess.length != 4
    puts "Your number should be 4 characters long."
    make_guess
  elsif new_guess =~ /0+|[7-9]+/
    puts "All characters must be between 1 and 6."
    make_guess
  else
    @guess = new_guess.chars
  end
end

def compare_answer(guess, answer)
  compared = []
  hits = []
  guess.each_with_index do |n, i|
    #puts "Guess #{n} answer #{answer[i]}"
    if n == answer[i]
      compared << n    
      hits << ' ● '
    end    
  end
  guess.each do |n|
    #puts "Guess #{n} answer #{answer[guess.index(n)]}"
    if answer.include?(n) && !compared.include?(n)
      hits << ' ○ '
    end
  end
  puts hits.join()
  @correct = true if hits.join() == " ●  ●  ●  ● "
end
