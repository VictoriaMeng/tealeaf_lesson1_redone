=begin
draw board
assign square id system for board
assign blanks/symbols to square id's
  Solution: A hash w/ square id's as keys, symbols as values

initalize game session
  Problems: How to save game session when restricted to local variables?
  Solution: Create an initialize method, assign returned board state to variable

have human select X or O, assign computer to opposite
  Solution: One method to select human symbol, another method to assign computer symbol, results assigned to variables
  Edited Solution: Combine both methods and assign symbols to a hash, to avoid need to symbols as multiple parameters

method to print instructions and prompt human square selection
  Solution: Loop
  error checking for invalid entries
  error checking for occupied squares
save human selection

randomize computer square selection
  -Improve AI
  - Solution: One method for completing computer row, second method for blocking human.
    - Having both checks in one method caused errors, where computer sometimes blocked human instead of finishing own row.
save computer square selection

game-end conditions
  - all squares filled
  - 3 in a row
    - Solution: Store winning lines array in a constant, to avoid inner scope issues

Adding randomized turn order?
  Solution: Remove 'Symbols' hash, store both 'Order' and 'Symbol' information in hash called "Players"
  
=end

require 'pry'

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
PLAYERS = [:human, :computer]

def say(string)
  puts "--> #{string}"
end

def initialize_board
  board = {}
  (1..9).each {|square| board[square] = " "}
  board
end

def assign_order
  order = {}
  order = players.sample
end

def draw_board(board)
  puts "       |       |      "
  puts "   #{board[1]}   |   #{board[2]}   |   #{board[3]}   "
  puts "       |       |      "
  puts "----------------------"
  puts "       |       |      "
  puts "   #{board[4]}   |   #{board[5]}   |   #{board[6]}   "
  puts "       |       |      "  
  puts "----------------------"
  puts "       |       |      "
  puts "   #{board[7]}   |   #{board[8]}   |   #{board[9]}   "
  puts "       |       |      " 
end 

def assign_symbols
  symbols = {}
  begin
    say "Select your symbol: X or O"
    human_symbol = gets.chomp
  end until human_symbol.upcase == "X" || human_symbol.upcase == "O"
  symbols[:human] = human_symbol.upcase
  case symbols[:human]
  when "X"
    symbols[:computer] = "O"
  else
    symbols[:computer] = "X"
  end
  symbols
end

def open_squares(board)
  board.keys.select {|square| board[square] == " "}
end

def human_turn(board, symbols)
  say "Enter 1 to 9 to place your piece."
  begin
    human_square = gets.chomp
    if !board.has_key?(human_square.to_i)
      say "That's not a valid square. Enter 1 to 9 to select a valid square."
    elsif board[human_square.to_i] != " "
      say "Square #{human_square} is occupied. Please pick another square."
    end
  end until board[human_square.to_i] == " "
  board[human_square.to_i] = symbols[:human]
  human_square.to_i
end

def computer_row(board, symbols)
  WINNING_LINES.each do |line|
    if board.values_at(*line).count(symbols[:computer]) == 2
      line.each {|square| return square if board[square] == " "}
    end
  end
  nil
end

def computer_blocks(board, symbols)
  WINNING_LINES.each do |line|
    if board.values_at(*line).count(symbols[:human]) == 2
      line.each {|square| return square if board[square] == " "}
    end
  end
  nil
end

def computer_turn(board, symbols)
  if computer_row(board, symbols)
    computer_square = computer_row(board, symbols)
  elsif computer_blocks(board, symbols)
    computer_square = computer_blocks(board, symbols)
  else
    computer_square = open_squares(board).sample
  end
  board[computer_square] = symbols[:computer]
  computer_square
end

def winner_check(board, symbols)
  WINNING_LINES.each do |line|
    return "You win!" if board.values_at(*line).count(symbols[:human]) == 3
    return "You lose!" if board.values_at(*line).count(symbols[:computer]) == 3
  end
  nil
end

def full_board_check(board)
  return "It's a tie!" if !board.has_value?(" ")
end

loop do 
  say "Let's play Tic-Tac-Toe."
  symbols = assign_symbols
  say "You are #{symbols[:human]}. Your opponent is #{symbols[:computer]}."
  board = initialize_board
  draw_board(board)

  begin
    square = human_turn(board, symbols)
    draw_board(board)
    say "You placed #{symbols[:human]} in Square #{square}."
    square = computer_turn(board, symbols)
    draw_board(board)
    say "Computer placed #{symbols[:computer]} in Square #{square}."
  end until winner_check(board, symbols) || full_board_check(board)

  if winner_check(board, symbols)
    say winner_check(board, symbols)
  else
    say full_board_check(board)
  end

  say "Press 'Y' to play again. Press any other key to exit."
  play_again = gets.chomp
  break unless play_again.downcase == "y"
end
  
  say "Thanks for playing!"


  

