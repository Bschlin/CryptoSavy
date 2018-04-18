class V1::FavoritesController < ApplicationController
  def create
    favorite = Favorite.new(
      user_id: params[:user_id],
      coin_name: params[:coin_name],
      coin_api_id: params[:coind_api_id],
      notes: params[:notes]
    )
    if favorite.save
      render json: favorite.as_json
    else 
      render json: {errors: favorite.errors.full_messages}, status: 422
    end
  end
end
