require_relative '../config/environment'



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
    elsif login_answer == "Log-in"
        system("clear")
        puts "please log in"
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

    user = User.create(name: "#{name.upcase!}", age: "#{age}", money: "#{money}")
end 

def log_in 
    

end

intro 

