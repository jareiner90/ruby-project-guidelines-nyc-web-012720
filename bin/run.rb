require_relative '../config/environment'
require 'rest-client'
require 'json'

ING_KEYS = ["strIngredient1",
"strIngredient2",
"strIngredient3",
"strIngredient4",
"strIngredient5",
"strIngredient6",
"strIngredient7",
"strIngredient8",
"strIngredient9",
"strIngredient10",
"strIngredient11",
"strIngredient12",
"strIngredient13",
"strIngredient14",
"strIngredient15"]

def api_return_name(drink)
    response_string = RestClient.get("https://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{drink}")
    response_hash = JSON.parse(response_string)
    drink_string = response_hash["drinks"]
    drink_string
end

def api_return_hash(drink)
    response_string = RestClient.get("https://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{drink}")
    response_hash = JSON.parse(response_string)
    response_hash["drinks"]
end 



def intro
    system("clear") 
    puts "Welcome to Bar Tinder!"
    gets.chomp
    welcome_menu
end 

def welcome_menu
    prompt = TTY::Prompt.new
    choices = ["Sign up", "Log-in", "Back"]
    login_answer = prompt.select("Please sign up or log-in: ", choices)
    if login_answer == "Sign up"
        system("clear")
        puts "Please sign up"
        create_user
        returned_drinks
    elsif login_answer == "Log-in"
        system("clear")
        puts "please log in"
        log_in
        returned_drinks
    else 
        login_answer == "Back"
        intro
    end
end 

def create_user
    prompt = TTY::Prompt.new
    name = prompt.ask("Please enter your full name")
    age = prompt.ask("please enter your age")
    money = prompt.ask("How much would you like to add to your account?")

    $user = User.create(name: "#{name.upcase!}", age: "#{age}", money: "#{money}")
end 

def log_in
    prompt = TTY::Prompt.new
    user_full = prompt.ask("What is your full name?")
    test = User.all.find do |user|
        user.name == user_full.upcase!
        
    end 
end

def returned_drinks
    prompt = TTY::Prompt.new
    selected_drink = prompt.ask("What kind of drink are you looking for")
    choices = []
    drinks = api_return_name(selected_drink)
    drinks.each do |drink_hash|
        choices << drink_hash["strDrink"]
    end
    drink_answer = prompt.select("Please select a drink...", choices)
    # drink_options(drink_answer, drinks)
    drink_options(drink_answer)

end 

def drink_options(drink) # def drink_options(drink, drinks)
    system("clear")
    prompt = TTY::Prompt.new
    choices = ["Ingredients", "Hows it made", "Purchase", "Back"]
    drink_answer = prompt.select("Please select a choice: ", choices)
    if drink_answer == choices[0]
        system("clear")
        puts "Here are the ingredients..."
        get_ingridients(drink) # get_ingridients(drink_name, drinks)
    elsif drink_answer == choices[1]
        system("clear")
        puts "Heses how its made:"
        get_instructions(drink) 
        

    elsif drink_answer == choices[2]
        system("clear")
        puts "purchase"
        purchase
    else 
        drink_answer == "Back"
        system("clear")
        returned_drinks
    end 
end 

def get_instructions(returned_drinks)
    prompt = TTY::Prompt.new
    drink_inst = api_return(returned_drinks).find do |drink_object|
    puts drink_object["strInstructions"]
    end 
    choices = ["Back"]
    back_button = prompt.select(drink_inst, choices)
    if back_button == "Back"
        drink_options(returned_drinks)
    end
end

def get_ingridients(drink_name) 
    prompt = TTY::Prompt.new
    found_drink = api_return_hash(drink_name)[0]
    ing = ING_KEYS.map do |value|
            found_drink[value] 
            # binding.pry
    end.uniq
    puts ing
    choices = ["Back"]
    back_button = prompt.select("", choices)
    if back_button == "Back"
        drink_options(drink_name)
    end
end

def purchase
    # puts $drink_answer
end 



intro
binding.pry