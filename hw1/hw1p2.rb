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

def player?(array)
    array.kind_of? Array and array.length == 2 and array.first.kind_of? String
end

def rps_tournament_winner(tournament)
    temp_tournament = tournament.clone
    while temp_tournament.length == 2 do
        game2 = temp_tournament.pop
        game1 = temp_tournament.pop

        temp_tournament.push(rps_game_winner [player?(game1) ? game1 : rps_tournament_winner(game1),
                                              player?(game2) ? game2 : rps_tournament_winner(game2)])
    end
    temp_tournament.pop
end

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