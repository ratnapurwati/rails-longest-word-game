require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    result = params[:words].upcase.split('').all? do |word|
      params[:grid].split.include?(word)
    end
    # raise
    search = "#{params[:letter]}"
    url = "https://wagon-dictionary.herokuapp.com/#{search}"
    query = URI.open(url).read
    english_word = JSON.parse(query)

    if english_word['found'] == true && result
      @english = “Congratulations! #{search} is a valid English word”
    elsif english_word['found'] == false
      @english = "Sorry but #{search} is not a valid English word"
    else
      @english = "Sorry but #{search} can not be built out of #{params[:grid]}"
    end
  end
end
