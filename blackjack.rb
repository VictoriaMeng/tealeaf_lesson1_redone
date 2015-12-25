=begin

Problem: Set up 52 card-deck creation method, with faces and numbers 2-10, jacks, queens, kings, aces
Solution: A hash, with suits as keys, arrays of numbers/faces as values
 - Better solution: One array for suits, one array for card values, .product method combines arrays. Each card is own array for flexible handling  

Problem: Deal hands and save hands
Solution: A method

  
  
=end

require "pry"

def say(string)
  puts "--> #{string}"
end

def instruct(instructions)
  puts " --- #{instructions} --- "
end

def enter_name
  instruct "What's your name?"
  name = gets.chomp
end

def new_deck
  deck = (2..10).to_a.concat(%w(Jack Queen King Ace(11))).product(%w(Hearts, Diamonds, Clubs, Spades))
end

def deal_card(deck, hand)
  card = deck.delete(deck.sample)
  hand[:cards].push(card)
  case card[0]
  when 2..10
    hand[:total] += card[0]
  when "Ace(11)"
    hand[:total] += 11
  else
    hand[:total] += 10
  end
end

def print_hand(name, hand)
  cards = hand[:cards].map {|card| "#{card[0]} of #{card[1]}"}.flatten
  say "#{name}'s Hand: #{cards} --- Total: #{hand[:total]}"
end


deck_1 = new_deck
deck_2 = new_deck
deck_3 = new_deck
deck_4 = new_deck
deck_5 = new_deck
deck_6 = new_deck
deck_7 = new_deck
deck_8 = new_deck
all_decks = []
all_decks.push(deck_1, deck_2, deck_3, deck_4, deck_5, deck_6, deck_7, deck_8)

name = enter_name
hands = {
          human: {
                  cards: [], 
                  total: 0
                  },
          computer: {
                      cards: [],
                      total: 0
                    }
        }

2.times {deal_card(all_decks.sample, hands[:human])}
2.times {deal_card(all_decks.sample, hands[:computer])}

print_hand(name, hands[:human])

