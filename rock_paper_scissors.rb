require 'pry'

HANDS = ["rock", "paper", "scissors"]

def say(message)
  puts "=> #{message}"
end

def result_player_rock(opponent_hand)
  if opponent_hand == "rock"
    "You picked Rock - Your opponent picked Rock. - It's a tie!"
  elsif opponent_hand == "paper"
    "You picked Rock - Your opponent picked Paper - You lose!"
  else
    "You picked Rock - Your opponent picked Scissors - You win!"
  end
end

def result_player_paper(opponent_hand)
  if opponent_hand == "rock"
    "You picked Paper - Your opponent picked Rock. - You win!"
  elsif opponent_hand == "paper"
    "You picked Paper - Your opponent picked Paper - It's a tie!"
  else
    "You picked Paper - Your opponent picked Scissors - You lose!"
  end
end

def result_player_scissors(opponent_hand)
  if opponent_hand == "rock"
    "You picked Scissors - Your opponent picked Rock. - You lose!"
  elsif opponent_hand == "paper"
    "You picked Scissors - Your opponent picked Paper - You win!"
  else
    "You picked Scissors - Your opponent picked Scissors - It's a tie!"
  end
end

say "Let's play Rock Paper Scissors!"

loop do
  say "Choose one: (R/P/S)"
  input = gets.chomp
  opponent_hand = HANDS.sample

  if input.downcase == "r" || input.downcase == "rock"
    say result_player_rock(opponent_hand)
  elsif input.downcase == "p" || input.downcase == "paper"
    say result_player_paper(opponent_hand)
  elsif input.downcase == "s" || input.downcase == "scissors"
    say result_player_scissors(opponent_hand)
  else
    say "You can only pick Rock, Paper, or Scissors! Choose one: (R/P/S)"
    redo
  end

  say "Press 'Y' to play again. Press any other key to exit."
  break if gets.chomp.downcase != "y" 
end

say "Thanks for playing!"
