require_relative 'answer'

answer_class = Answer.new

class GameManager
  attr_accessor :guess, :answer

  def initialize
    @guess = ''
    @answer = ''
  end
end

@answer = answer_class.new_answer

def getGuess
  @guess
end

def getAnswer
  @answer
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
  guess.each_with_index do |n, i|
    #puts "Guess #{n} answer #{answer[i]}"
    if n == answer[i]
      puts "et voilá"
      compared << n    
    end    
  end
  guess.each do |n|
    #puts "Guess #{n} answer #{answer[guess.index(n)]}"
    if answer.include?(n) && !compared.include?(n)
      puts "oopsie!"
    end
  end
end
