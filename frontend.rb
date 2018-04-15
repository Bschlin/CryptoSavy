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

