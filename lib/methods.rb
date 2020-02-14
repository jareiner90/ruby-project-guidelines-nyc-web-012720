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
    # system("clear") 
    puts "
    .S_SSSs     .S_SSSs     .S_sSSs          sdSS_SSSSSSbs   .S   .S_sSSs     .S_sSSs      sSSs   .S_sSSs    
   .SS~SSSSS   .SS~SSSSS   .SS~YS%%b         YSSS~S%SSSSSP  .SS  .SS~YS%%b   .SS~YS%%b    d%%SP  .SS~YS%%b   
   S%S   SSSS  S%S   SSSS  S%S   `S%b             S%S       S%S  S%S   `S%b  S%S   `S%b  d%S'    S%S   `S%b  
   S%S    S%S  S%S    S%S  S%S    S%S             S%S       S%S  S%S    S%S  S%S    S%S  S%S     S%S    S%S  
   S%S SSSS%P  S%S SSSS%S  S%S    d*S             S&S       S&S  S%S    S&S  S%S    S&S  S&S     S%S    d*S  
   S&S  SSSY   S&S  SSS%S  S&S   .S*S             S&S       S&S  S&S    S&S  S&S    S&S  S&S_Ss  S&S   .S*S  
   S&S    S&S  S&S    S&S  S&S_sdSSS              S&S       S&S  S&S    S&S  S&S    S&S  S&S~SP  S&S_sdSSS   
   S&S    S&S  S&S    S&S  S&S~YSY%b              S&S       S&S  S&S    S&S  S&S    S&S  S&S     S&S~YSY%b   
   S*S    S&S  S*S    S&S  S*S   `S%b             S*S       S*S  S*S    S*S  S*S    d*S  S*b     S*S   `S%b  
   S*S    S*S  S*S    S*S  S*S    S%S             S*S       S*S  S*S    S*S  S*S   .S*S  S*S.    S*S    S%S  
   S*S SSSSP   S*S    S*S  S*S    S&S             S*S       S*S  S*S    S*S  S*S_sdSSS    SSSbs  S*S    S&S  
   S*S  SSY    SSS    S*S  S*S    SSS             S*S       S*S  S*S    SSS  SSS~YSSY      YSSP  S*S    SSS  
   SP                 SP   SP                     SP        SP   SP                              SP          
   Y                  Y    Y                      Y         Y    Y                               Y           
                                                                                                             
   "
    gets.chomp
end 

def create_login_user 
    prompt = TTY::Prompt.new
        name = prompt.ask("Please enter your full name")
        $user = User.find_or_create_by(name: "#{name.upcase!}")
end

# continues the program
def option_menu
    system("clear")
    prompt = TTY::Prompt.new
    choices = ["Find a Drink", "Check Orders", "Exit"]
    login_answer = prompt.select("What would you like to do?", choices)
end 


# creates a new user
# def create_user
#     prompt = TTY::Prompt.new
#     name = prompt.ask("Please enter your full name")
#     age = prompt.ask("please enter your age")
#     money = prompt.ask("How much would you like to add to your account?")
#     $user = User.create(name: "#{name.upcase!}", age: "#{age}", money: "#{money}")
# end 

# # finds a curent user 
# def log_in
#     prompt = TTY::Prompt.new
#     user_full = prompt.ask("What is your full name?")
#     test = User.all.find do |user|
#         user.name == user_full.upcase!
#     end 
# end


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

def drink_options(drink) 
    prompt = TTY::Prompt.new
    choices = ["Ingredients", "Hows it made", "Purchase", "Back"]
    drink_answer = prompt.select("Please select a choice: ", choices)
end 

def get_instructions(returned_drinks)
    prompt = TTY::Prompt.new
    drink_inst = api_return_name(returned_drinks).find do |drink_object|
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
end

def ingredients_to_string(array)
    array.join(",")
end 


def add_drink(drink_name)
    found_drink = api_return_hash(drink_name)[0]
    $ing = ING_KEYS.map do |value|
            found_drink[value] 
            
    end.uniq
    ing_drink = $ing.join(",")

    new_drink = Drink.create(name: drink_name,ingridents: ing_drink)
    
    current_user = User.all.find do |user| 
        user.name == $user.name
    end 
    new_order = Order.create(user: current_user, drink: new_drink)
   
end 

def orders
    prompt = TTY::Prompt.new
    drink_names = $user.orders.map do |order| 
        order.drink.name
    end 
    choices = drink_names
    prompt.select("Please select an Drink order ", choices)
end

def update_delete
    prompt = TTY::Prompt.new
    choices = ["Update", "Delete"]
    prompt.select("Update or Delete an Order", choices)
end

def delete(drink_name)
    user_drink = $user.orders.find{|order| order.drink.name == drink_name}.destroy
end

def update(drink_name)
    prompt = TTY::Prompt.new
    user_drink = $user.orders.find{|order| order.drink.name == drink_name}
    chosen_drink = user_drink.drink
    ingrident = chosen_drink.ingridents
    choices = ingrident.split(",")
    
    ing_to_change = prompt.select("What ingridient would you like to change", choices)
    index_of_choices = choices.index(ing_to_change) #2

    whateverthefuck = prompt.ask("What would you like to change the ingridient to?")

    choices[index_of_choices] = whateverthefuck
    new_string = choices.join(',')

    puts "Your updated ing are #{new_string}"

    chosen_drink.update(ingridents: new_string)
end

00
