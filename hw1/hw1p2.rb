#!/usr/bin/env ruby

class WrongNumberOfPlayersError < StandardError ; end
class NoSuchStrategyError < StandardError ; end

def rps_game_winner(game)
  raise WrongNumberOfPlayersError unless game.length == 2
  
  h = Hash.new 0
  h["sr"] = h["ps"] = h["rp"] = 1

  combo = ""
  game.each {|n, s| raise NoSuchStrategyError unless ["p", "r", "s"].include? s.downcase ; combo << s }
  
  game[h[combo.downcase]]
end

print (rps_game_winner [["Armando", "P"], ["Dave", "S"]]), "\n"
print (rps_game_winner [["Armando", "S"], ["Dave", "R"]]), "\n"
print (rps_game_winner [["Armando", "S"], ["Dave", "S"]]), "\n"
#print (rps_game_winner [["Armando", "S"], ["Dave", "K"]]), "\n"

class WrongNumberOfGamesError < StandardError ; end

def rps_tournament_winner(tournament)
  raise WrongNumberOfGamesError unless tournament.length == 2
  # if game
  if tournament.length == 2 and
    tournament[0].kind_of? Array and tournament[0][0].kind_of? String and
    tournament[1].kind_of? Array and tournament[1][0].kind_of? String
    rps_game_winner tournament
  else
    rps_tournament_winner [rps_tournament_winner(tournament[0]), rps_tournament_winner(tournament[1])]
  end
end

# [[[["Armando", "P"],["Dave", "S"]],[["Richard", "R"],["Michael", "S"]]],[[["Allen", "S"],["Omer", "P"]],[["David E.", "R"],["Richard X.", "P"]]]]
print (rps_tournament_winner [["Armando", "P"], ["Dave", "S"]]), "\n"
print (rps_tournament_winner [
                               [
                                 [
                                   ["Armando", "P"],
                                   ["Dave", "S"]
                                 ],
                                 [
                                   ["Richard", "R"],
                                   ["Michael", "S"]
                                 ]
                               ],
                               [
                                 [
                                   ["Allen", "S"],
                                   ["Omer", "P"]
                                 ],
                                 [
                                  ["David E.", "R"],
                                  ["Richard X.", "P"]
                                 ]
                               ]
                             ]), "\n"
print (rps_tournament_winner [
                               [
                                 ["Dave", "S"],
                                 [
                                   ["Richard", "R"],
                                   ["Michael", "S"]
                                 ]
                               ],
                               [
                                 [
                                   ["Allen", "S"],
                                   ["Omer", "P"]
                                 ],
                                 [
                                  ["David E.", "R"],
                                  ["Richard X.", "P"]
                                 ]
                               ]
                             ]), "\n"