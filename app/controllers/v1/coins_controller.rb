class V1::CoinsController < ApplicationController
  def index
    # Use Unirest with some API to get a list of coins (no user input required)

    render json: response.body
  end

  def show
    response = Unirest.get("https://min-api.cryptocompare.com/data/pricemultifull?fsyms=ETH&tsyms=USD")
    # get coin api id from user (params[:coin_api_id]...)

  end

  
end
