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



# returns drink name through a string 
def api_return_name(drink)
    response_string = RestClient.get("https://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{drink}")
    response_hash = JSON.parse(response_string)
    drink_string = response_hash["drinks"]
    drink_string
end

# returns the drink search from the api, could be multiple drinks
def api_return_hash(drink)
    response_string = RestClient.get("https://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{drink}")
    response_hash = JSON.parse(response_string)
    response_hash["drinks"]
end 


# starts the program
def intro
    system("clear") 
    puts "Welcome to Bar Tinder!"
    gets.chomp
end 

# continues the program
def welcome_menu
    system("clear")
    prompt = TTY::Prompt.new
    choices = ["Sign up", "Log-in", "Exit"]
    login_answer = prompt.select("Please sign up or log-in: ", choices)
end 

def create_login_user(login_answer)
    prompt = TTY::Prompt.new
    if login_answer == "Sign up"
        name = prompt.ask("Please enter your full name")
        age = prompt.ask("please enter your age")
        money = prompt.ask("How much would you like to add to your account?")
        user = User.find_or_create_by(name: "#{name.upcase!}", age: "#{age}", money: "#{money}")
    elsif login_answer == "Log-in"
        user_full = prompt.ask("What is your full name?")
        user = User.find_or_create_by(name: "#{user_full.upcase!}")
    end
end

# creates a new user
def create_user
    prompt = TTY::Prompt.new
    name = prompt.ask("Please enter your full name")
    age = prompt.ask("please enter your age")
    money = prompt.ask("How much would you like to add to your account?")
    $user = User.create(name: "#{name.upcase!}", age: "#{age}", money: "#{money}")
end 

# finds a curent user 
def log_in
    prompt = TTY::Prompt.new
    user_full = prompt.ask("What is your full name?")
    test = User.all.find do |user|
        user.name == user_full.upcase!
    end 
end


# Return the chosen drink from the api and what the user selected
def returned_drinks
    prompt = TTY::Prompt.new
    selected_drink = prompt.ask("What kind of drink are you looking for")
    choices = []
    drinks = api_return_name(selected_drink)
    drinks.each do |drink_hash|
        choices << drink_hash["strDrink"]
    end
    drink_answer = prompt.select("Please select a drink...", choices)
    
    
end 

def drink_options(drink) # def drink_options(drink, drinks)
    system("clear")
    prompt = TTY::Prompt.new
    choices = ["Ingredients", "Hows it made", "Purchase", "Back"]
    drink_answer = prompt.select("Please select a choice: ", choices)
    # if drink_answer == choices[0]
    #     system("clear")
    #     puts "Here are the ingredients..."
    #     get_ingridients(drink) # get_ingridients(drink_name, drinks)
    # elsif drink_answer == choices[1]
    #     system("clear")
    #     puts "Heses how its made:"
    #     get_instructions(drink) 
        

    # elsif drink_answer == choices[2]
    #     system("clear")
    #     puts "purchase"
    #     purchase($drink_answer, ingredients_to_string($ing), 7)
    # else 
    #     drink_answer == "Back"
    #     system("clear")
    #     returned_drinks
    # end 
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
    $ing = ING_KEYS.map do |value|
            found_drink[value] 
            
    end.uniq
    puts $ing
    choices = ["Back"]
    back_button = prompt.select("", choices)
    if back_button == "Back"
        drink_options(drink_name)
    end
end

def ingredients_to_string(array)
    array.join(",")
end 


def purchase(d_name, d_ing, price)
    puts d_name
    puts d_ing
    puts price
end 







00