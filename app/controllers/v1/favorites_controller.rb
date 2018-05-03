class V1::FavoritesController < ApplicationController
  def index 
    favorites = Favorite.all
    render json: favorites.as_json
  end 

  def create
    favorite = Favorite.new(
        user_id: params[:user_id],
        coin_name: params[:coin_name],
        coin_api_id: params[:coin_api_id],
        notes: params[:notes]
      )
    if favorite.save
      render json: favorite.as_json
      else 
        render json: {errors: favorite.errors.full_messages}, status: 422
    end
  end

  def destroy
    favorite_id = params["id"]
    favorite = Favorite.find_by(id: favorite_id)
    favorite.destroy
    render json: {message: "Product successfully destroyed!"} 
  end 
end
