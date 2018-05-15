class UserTokenController < Knock::AuthTokenController
  def create
    email = request.params["auth"] && request.params["auth"]["email"]
    user = User.find_by(email: email)
    body = {
      jwt: auth_token.token,
      user: { id: user.id, first_name: user.first_name, last_name: user.last_name, email: user.email }
    }
    render json: body, status: :created
  end
end
