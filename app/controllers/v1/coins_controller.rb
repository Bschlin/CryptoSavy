class V1::CoinsController < ApplicationController
  def index
    # Use Unirest with some API to get a list of coins (no user input required)
    response = Unirest.get("https://api.coinmarketcap.com/v2/listings/")
    render json: response.body["data"]
  end

  def show
    response = Unirest.get("https://min-api.cryptocompare.com/data/pricemultifull?fsyms=#{params[:id]}&tsyms=USD")
    render json: response.body
    # get coin api id from user (params[:coin_api_id]...)
    # coin_id = params[:coin_api_id]
    # coin = User.find_by(coin_api_id: coin_id)
    # render json: user.as_json

  end

  
end
