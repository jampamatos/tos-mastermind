require_relative 'messages'
require 'pry-byebug'

@guess = ''
@answer = ''
@correct = false

@human_turn = false
@computer_turn = false
@human_score = 0
@computer_score = 0

@computer_hits = []
@prev_hits = []
@num_to_try = 1

@ai_correct_num = []
@ai_guessed = []

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
  @answer = computer_answer
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
  @computer_hits = []
  @prev_hits = []
  @ai_correct_num = []
  @ai_guessed = []
  @num_to_try = 1

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
  @guess = ''
  @answer = ''

  puts "#{'Scoreboard'.colorize(:red).bold}:"
  puts "#{'Human'.bold}: #{@human_score}"
  puts "#{'Computer'.bold}: #{@computer_score}"
  puts ''
  sleep(1)

  h_turns = human_turn
  if h_turns == 50
    puts "You did not break computer's code."
    puts "Computer played #{@answer.join('')}"
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

  replay

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
  puts "#{'Final Score'.colorize(:red).bold}:"
  puts "#{'Human'.bold}: #{@human_score}"
  puts "#{'Computer'.bold}: #{@computer_score}"
  puts ''
  puts 'Thank you for playing!'
end

def start
  start_msg
  puts ''
  start_round
end

def make_guess
  puts "Type in a number 4 characters long, from 1 to 6:"
  new_guess = gets.chomp
  if new_guess.length != 4
    puts "Your number should be 4 characters long."
    make_guess
  elsif new_guess =~ /0+|[7-9]+|[a-zA-Z]/
    puts "All characters must be numbers between 1 and 6."
    make_guess
  else
    return new_guess.chars
  end
end

def compare_answer(guess, answer)
  compared_guess_i = []
  compared_answer_i = []
  hits = []
  @computer_hits = hits if @computer_turn == true
  
  guess.each_with_index do |n, i|
    if n == answer[i]
      compared_guess_i << i
      compared_answer_i << i
      hits << ' ● '
    end    
  end   

  answer.each_with_index do |ans_n, ans_i|
    guess.each_with_index do |guess_n, guess_i|
      if !compared_guess_i.include?(guess_i) && !compared_answer_i.include?(ans_i)
        if guess_n == ans_n
          compared_guess_i << guess_i
          compared_answer_i << ans_i
          hits << ' ○ '
        end
      end
    end
  end

  puts hits.join()
  @correct = true if hits.join() == " ●  ●  ●  ● "
end

def computer_answer
  num = []
  4.times do
    num << rand(1..6).to_s
  end
  return num
end

def computer_guess

  num_to_guess = []
  
  if @computer_hits == []
    4.times { num_to_guess << @num_to_try.to_s }
    @ai_guessed << num_to_guess.join().to_s
  end

  if @ai_correct_num.length < 4

    new_hits = @computer_hits.length - @prev_hits.length

    if @computer_hits.length >=1 && @ai_correct_num == [] || @computer_hits.length >=1 && (@ai_correct_num.none?(@num_to_try - 1).to_s)
      new_hits.times { @ai_correct_num << (@num_to_try - 1).to_s } 
    end

    @prev_hits = []
    @computer_hits.each { |e| @prev_hits << e}

    @ai_correct_num.each { |e| num_to_guess << e.dup.to_s }
    (4 - num_to_guess.length).times { num_to_guess << @num_to_try.to_s }
    @ai_guessed << num_to_guess.join().to_s

    if @ai_correct_num.length == 4
      num_to_guess = []
      new_guess = shuffle_nums
      new_guess.each { |e| num_to_guess << e.dup.to_s }
      @ai_guessed << num_to_guess.join().to_s
    end

  elsif @computer_hits.length == 4
    new_guess = shuffle_nums
    new_guess.each { |e| num_to_guess << e.dup.to_s }
      @ai_guessed << num_to_guess.join().to_s
  end
    
  @num_to_try += 1
  return num_to_guess

end

def shuffle_nums
  nums_shuffled = @ai_correct_num.shuffle
  if @ai_guessed.include?(nums_shuffled.join().to_s)
    nums_shuffled = shuffle_nums      
  end
  return nums_shuffled
end
