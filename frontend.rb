require "unirest"

system "clear"
puts "Welcome to CryptoSavy! Choose an option:"
puts "[signup] Signup (create a user)"
puts "[login] Login (create a JSON web token)"
puts "[logout] Logout (delete the JSON web token)"

input_option = gets.chomp
if input_option == "signup"
  params = {}
  print "First Name: "
  params[:first_name] = gets.chomp
  print "Last Name: "
  params[:last_name] = gets.chomp
  print "Email: "
  params[:email] = gets.chomp
  print "Phone Number: "
  params[:phone_number] = gets.chomp
  print "Password: "
  params[:password] = gets.chomp
  print "Password Confirmation: "
  params[:password_confirmation] = gets.chomp
  response = Unirest.post("http://localhost:3000/v1/users", parameters: params)
  p response.body
  elsif input_option == "login"
    params = {}
    puts "Please enter your email"
    input_email = gets.chomp
    puts "Enter a password"
    input_password = gets.chomp 
    response = Unirest.post(
    "http://localhost:3000/user_token",
    parameters: {
      auth: {
        email: input_email,
        password: input_password
      }
    }
  )
    jwt = response.body["jwt"]
    Unirest.default_header("Authorization", "Bearer #{jwt}")
  elsif input_option == "logout"
    jwt = ""
    Unirest.clear_default_headers()

end

system "clear"
puts "Choose an option"
puts "[1] Show all Favorites(favorites index action)"
puts "[1.1] Create a NEW Favorite(favorites create action)"
puts "[1.2] Delete a favorite(favorites destroy action"
puts "[2] Coins Index"
puts "[2.1] Search Coins by Ticker Symbol"
puts "[3] show multiple Wallet address balances"
puts "[3.1] show Wallet address balance"




input_option = gets.chomp
if input_option == "1"
  response = Unirest.get("http://localhost:3000/v1/favorites")
  favorites = response.body
  puts JSON.pretty_generate(favorites)
elsif input_option == "1.1"
  params = {}
  print "Enter a coin ID: "
  params[:user_id] = gets.chomp
  print "Enter a coin name: "
  params[:coin_name] = gets.chomp
  print "Enter coin API ID: "
  params[:coin_api_id] = gets.chomp
  print "Enter some notes: "
  params[:notes] = gets.chomp
  response = Unirest.post("http://localhost:3000/v1/favorites", parameters: params)
  favorites = response.body
elsif input_option == "1.2"
  print "Enter a favorites id: "
  favorite_id = gets.chomp
  response = Unirest.delete("http://localhost:3000/v1/favorites/#{favorite_id}")
  body = response.body
  puts JSON.pretty_generate(body)
elsif input_option == "2"
  response = Unirest.get("http://localhost:3000/v1/coins")
  coins = response.body
  puts JSON.pretty_generate(coins)
elsif input_option == "2.1"
  params = {}
  print "Enter a coin ticker symbol: "
  input_name = gets.chomp
  response = Unirest.get("http://localhost:3000/v1/coins/#{input_name}")
  p response.body
elsif input_option == "3"
  response = Unirest.get("http://localhost:3000/v1/wallets")
  wallets = response.body
  puts JSON.pretty_generate(wallets)
elsif input_option == "3.1"
  params = {}
  print "Enter a bitcoin wallet address: "
  input_name = gets.chomp
  response = Unirest.get("http://localhost:3000/v1/wallets/#{input_name}")
  p response.body
end

# show all coins
# response = Unirest.get("http://localhost:3000/v1/coins")
# p response.body

# show one coin
# response = Unirest.get("http://localhost:3000/v1/coins/BTC")
# p response.body