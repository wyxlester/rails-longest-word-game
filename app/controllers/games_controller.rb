require 'uri'
require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @user_input = params[:input]
    @letters = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{@user_input}"
    score_serialized = URI.open(url).read
    score = JSON.parse(score_serialized)
    validity = @user_input.split('').all? { |element| @letters.include? element }

    if validity == false
      @output_message = 'Word not found in grid'
    elsif score['found'] == false && validity == true
      @output_message = 'Invalid English word'
    elsif score['found'] == true && validity == true
      @output_message = 'Valid word according to grid and is a English word'
    else
      @output_message = 'Please enter a valid word'
    end
  end
end
