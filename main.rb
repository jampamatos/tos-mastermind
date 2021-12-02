require_relative 'game_manager'

make_guess

guess = getGuess
answer = getAnswer

compare_answer(guess, answer)