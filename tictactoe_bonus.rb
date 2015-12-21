require "pry"

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

def say(string)
  puts "--> #{string}"
end

def initialize_board
  board = {}
  (1..9).each {|square| board[square] = " "}
  board
end

def draw_board(board)
  system "clear"
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
  players = {human: {}, computer: {}}
  begin
    say "Select your symbol: X or O"
    human_symbol = gets.chomp
  end until human_symbol.upcase == "X" || human_symbol.upcase == "O"
  players[:human][:symbol] = human_symbol.upcase
  case players[:human][:symbol]
  when "X"
    players[:computer][:symbol] = "O"
  else
    players[:computer][:symbol] = "X"
  end
  players
end

def assign_order(players)
  if players.keys.sample == :human
    players[:human][:order] = "player_1"
    players[:computer][:order] = "player_2"
  else
    players[:computer][:order] = "player_1"
    players[:human][:order] = "player_2"
  end
end

def open_squares(board)
  board.keys.select {|square| board[square] == " "}
end

def human_turn(board, symbol)
  say "Enter 1 to 9 to place your piece."
  begin
    human_square = gets.chomp
    if !board.has_key?(human_square.to_i)
      say "That's not a valid square. Enter 1 to 9 to select a valid square."
    elsif board[human_square.to_i] != " "
      say "Square #{human_square} is occupied. Please pick another square."
    end
  end until board[human_square.to_i] == " "
  board[human_square.to_i] = symbol
  human_square.to_i
end

def fill_row(board, symbol)
  WINNING_LINES.each do |line|
    if board.values_at(*line).count(symbol) == 2
      line.each {|square| return square if board[square] == " "}
    end
  end
  nil
end

def computer_turn(board, players)
  if board[5] == " "
    computer_square = 5
  elsif fill_row(board, players[:computer][:symbol])
    computer_square = fill_row(board, players[:computer][:symbol])
  elsif fill_row(board, players[:human][:symbol])
    computer_square = fill_row(board, players[:human][:symbol])
  else
    computer_square = open_squares(board).sample
  end
  board[computer_square] = players[:computer][:symbol]
  computer_square
end

def turn(board, players, whose_turn)
  if players[:human][:order] == whose_turn
    human_turn(board, players[:human][:symbol])
  else
    computer_turn(board, players)
  end
end

def computer_turn_summary(computer, whose_turn, square)
  say "Opponent placed #{computer[:symbol]} in Square #{square}." if computer[:order] == whose_turn
end

def winner_check(board, players)
  WINNING_LINES.each do |line|
    return "You win!" if board.values_at(*line).count(players[:human][:symbol]) == 3
    return "You lose!" if board.values_at(*line).count(players[:computer][:symbol]) == 3
  end
  nil
end

def full_board_check(board)
  return "It's a tie!" if !board.has_value?(" ")
end

loop do 
  say "Let's play Tic-Tac-Toe."
  players = assign_symbols
  assign_order(players)
  board = initialize_board
  draw_board(board)

  begin
    square = turn(board, players, "player_1")
    draw_board(board)
    computer_turn_summary(players[:computer], "player_1", square)
    break if winner_check(board, players) || full_board_check(board)
    square = turn(board, players, "player_2")
    draw_board(board)
    computer_turn_summary(players[:computer], "player_2", square)
  end until winner_check(board, players) || full_board_check(board)

  if winner_check(board, players)
    say winner_check(board, players)
  else
    say full_board_check(board)
  end

  say "Press 'Y' to play again. Press any other key to exit."
  play_again = gets.chomp
  break unless play_again.downcase == "y"
end
  
say "Thanks for playing!"