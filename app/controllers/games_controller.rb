require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    @letters << ('a'..'z').to_a.sample(1) while @letters.size != 10
  end

  def score
    @play = params[:play]
    @grid = params[:letters].gsub(/\s+/, "")
    ## check inside grid
    ## raise
    inside_grid?(@play, @grid) ? @score = (english_word?(@play)) : @score = "not in the grid"
    ## check english word
  end

  def english_word?(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    user_serialized = URI.open(url).read
    user = JSON.parse(user_serialized)

    if user["found"] == false
      return "not an english word"
    else
      return "Well done!"
    end
  end

  def inside_grid?(attempt, grid)
    letters_used = attempt.downcase.chars
    ## grid.map! { |letter| letter.downcase }

    letters_used.each do |i|
      if grid.include?(i)
        grid[grid.index(i)] = ""
      else
        return false
      end
    end
  end
end
