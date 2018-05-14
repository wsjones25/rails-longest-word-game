require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = ("A".."Z").to_a.sample(8)
  end

  def score
    @guess = params[:guess]
    @letters = params[:letters]
    if included?(@guess, @letters)
      if english_word?(@guess)
        @answer = "The word is valid according to the grid and is an English word"
      else
        @answer = "The word is valid according to the grid, but is not a valid English word"
      end
    else
      @answer = "The word can't be built out of the original grid"
    end
  end
end


def english_word?(word)
  response = open("https://wagon-dictionary.herokuapp.com/#{word}")
  json = JSON.parse(response.read)
  return json['found']
end

def included?(guess, letters)
  guess.upcase.chars.all? { |letter| guess.count(letter) <= letters.count(letter) }
end
