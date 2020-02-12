require_relative '../config/environment'
# $cli = CLI.new


 
while true 
    intro
    login_answer = welcome_menu

    if login_answer == 'Exit'
        break 
        if create_login_user(welcome_response)
        end
    end
        

    # else 
    #     if welcome_response == 'Sign up'
    #         create_user
    #         drink = returned_drinks 
    #         drink_answer = drink_options(drink)
    #         if drink_answer == "Ingredients"
    #             get_ingridients(drink)

    #         elsif drink_answer == "Hows it made"
    #             get_instructions(drink)

    #         elsif drink_answer == "Purchase"
    #             puts "purchase"

    #         end


    #     else
    #         log_in 
    #         drink = returned_drinks
    #         drink_options(drink)
    #         if drink_answer == "Ingredients"
    #             get_ingridients(drink)

    #         elsif drink_answer == "Hows it made"
    #             get_instructions(drink)

    #         elsif drink_answer == "Purchase"
    #             puts "purchase"

    #         end
    #     end 
end 