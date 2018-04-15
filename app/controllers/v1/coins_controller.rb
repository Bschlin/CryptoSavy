class V1::CoinsController < ApplicationController
  def index
    # Use Unirest with some API to get a list of coins

    # print "Enter a subreddit:"
    # input_word = gets.chomp
    # response = Unirest.get("https://min-api.cryptocompare.com/data/pricemultifull?fsyms=#{input_word}&tsyms=USD")

    render json: response.body
  end

  
end
