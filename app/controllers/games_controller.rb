require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.shuffle[0..9]
  end

  def score
    @word = params[:answer].upcase
    @included = included?(@word)
    @english_word = english_word?(@word)
  end

  private

  def included?(word)
    word.include?(@letters.join(''))
  end

  def english_word?(word)
    url = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(url.read)
    json['found']
  end
end
