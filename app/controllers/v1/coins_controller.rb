class V1::CoinsController < ApplicationController
  def index
    # Use Unirest with some API to get a list of coins
    response = Unirest.get("")

    render json: response.body
  end

  
end
