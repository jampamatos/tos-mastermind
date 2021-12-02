require_relative 'computer_player'
require_relative 'messages'

include ComputerPlayer

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
  welcome
  choice = main_menu_message
  menu_selection(choice)
end

def menu_selection(choice)
  if choice.to_i == 1
    start
  elsif choice.to_i == 2
    exit_game
  else
    puts ''
    puts "Wrong input."
    new_choice = main_menu_message
    menu_selection(new_choice)
  end
end

def define_answer
  puts "Create a code 4 numbers long, from 1 to 6:"
  play_answer = gets.chomp
  if play_answer.length != 4
    puts "Your number should be 4 characters long."
    define_answer
  elsif play_answer =~ /0+|[7-9]+/
    puts "All characters must be between 1 and 6."
    play_answer
  else
    return play_answer.chars
  end
end

def human_turn
  @correct = false
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

  guesses = 50 if guesses >= 10
  
  return guesses
end

def computer_turn
  @correct = false
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
    @guess = computer_guess
    puts "Computer guessed: #{@guess.join}"
    puts "Your code: #{@answer.join}"
    compare_answer(@guess, @answer)
    sleep(2)
    break if @correct == true
    guesses += 1
  end

  guesses = 50 if guesses >= 10
  
  return guesses
end

def start_round
  human_points = ''
  computer_points = ''

  puts "#{'Scoreboard'.colorize(:red).bold}:"
  puts "#{'Human'.bold}: #{@human_score}"
  puts "#{'Computer'.bold}: #{@computer_score}"
  puts ''
  sleep(1)

  h_turns = human_turn
  if h_turns == 50
    puts "You did not break computer's code."
    puts "Computer played #{@answer}"
    human_points = 'could not break code'
  else
    puts "You guessed in #{h_turns} turns."
    human_points = "guessed in #{h_turns} turns"
  end

  sleep(2)

  c_turns = computer_turn
  if c_turns == 50
    puts "Computer couldn't break your code!"
    computer_points = 'could not break code'
  else
    puts "Computer guessed in #{c_turns} turns."
    computer_points = "guessed in #{c_turns} turns"
  end

  puts ''
  puts "Human #{human_points}."
  puts "Computer #{computer_points}"
  puts ''
  if h_turns.to_i < c_turns.to_i
    puts "You win!"
    @human_score += 1
  elsif c_turns.to_i < h_turns.to_i
    puts "Computer wins!"
    @computer_score += 1
  else
    puts "It's a draw!"
  end
end

def replay
  puts 'Do you want to play again?'
  puts '(Y/N)'
  again = gets.chomp.upcase

  if again == 'Y'
    start_round
  elsif again == 'N'
    exit_game
  else
    puts 'Please type Y or N.'
    replay
  end
end

def exit_game
  system 'clear'
  puts 'Thank you for playing!'
end

def start
  start_msg
  puts ''
  start_round
  replay
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
