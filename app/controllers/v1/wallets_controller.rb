class V1::WalletsController < ApplicationController
  # def index
  #    response = Unirest.get("https://blockchain.info/balance?active=$address|$address")
  #   render json: response.body
  # end 

  def show
     # response = Unirest.get("https://min-api.cryptocompare.com/data/pricemultifull?fsyms=#{params[:id]}&tsyms=USD")
     response = Unirest.get("https://blockchain.info/balance?active=#{params[:id]}")
    render json: response.body
  end 
end
