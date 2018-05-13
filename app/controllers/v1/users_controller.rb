class V1::UsersController < ApplicationController
  def create
    user = User.new(
    first_name: params[:first_name],
    last_name: params[:last_name],
    email: params[:email],
    phone_number: params[:phone_number],
    password: params[:password],
    password_confirmation: params[:password_confirmation]
    )
    if user.save
      render json: {message: 'User created successfully'}, status: :created
  else
    render json: {errors: user.errors.full_messages}, status: :bad_request
    end
  end
  def current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end
end
