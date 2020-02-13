require_relative '../config/environment'
# $cli = CLI.new

# while true 
#     intro
#     create_login_user
#     chosen_option = option_menu
#         if chosen_option == "Find a Drink"
#             drink_answer = returned_drinks
#             search_option = drink_options(drink_answer)
#                 if search_option == "Ingredients"
#                     puts "Here are the ingredients..."
#                     get_ingridients(drink_answer)
#                     gets.chomp
#                     drink_answer
#                 elsif search_option == "Hows it made"
#                     puts "Heses how its made:"
#                     get_instructions(drink_answer)
#                 elsif search_option == "Purchase"
#                     add_drink(drink_answer)
#                     # new_drink = Drink.new(drink_answer, "some string", 7)
#                 else search_option == "Back"
#                     returned_drinks
#                 end
#             elsif chosen_option == "Check Orders"
#                 puts "here are your oders"
#                 chosen_drink = orders
#                 u_d = update_delete
#                     if u_d == "Update"
#                         update(chosen_drink)
#                         option_menu
#                     else u_d == "Delete"
#                         delete(chosen_drink)
#                         option_menu 
#                     end
#             else chosen_option == "Exit"
#                 break
#             end
# end 


def game_loop

    chosen_option = option_menu
        if chosen_option == "Find a Drink"
            drink_answer = returned_drinks
            search_option = drink_options(drink_answer)
                if search_option == "Ingredients"
                    puts "Here are the ingredients..."
                    get_ingridients(drink_answer)
                    gets.chomp
                    drink_answer
                elsif search_option == "Hows it made"
                    puts "Heses how its made:"
                    get_instructions(drink_answer)
                elsif search_option == "Purchase"
                    add_drink(drink_answer)
                    # new_drink = Drink.new(drink_answer, "some string", 7)
                else search_option == "Back"
                    returned_drinks
                end
                game_loop
            elsif chosen_option == "Check Orders"
                puts "here are your oders"
                chosen_drink = orders
                u_d = update_delete
                    if u_d == "Update"
                        update(chosen_drink)
                        option_menu
                    else u_d == "Delete"
                        delete(chosen_drink)
                        option_menu 
                    end
                    game_loop
            else chosen_option == "Exit"
                return
            end
            return
end 

intro
create_login_user
game_loop

            #  if login_answer == 'Exit'
    #     break 
    #  else create_login_user(login_answer)
    # end
    # drink_answer = returned_drinks
    # search_option = drink_options(drink_answer)
    #     if search_option == "Ingredients"
    #         puts "Here are the ingredients..."
    #         get_ingridients(drink_answer)
    #     elsif search_option == "Hows it made"
    #         puts "Heses how its made:"
    #         get_instructions(drink_answer)
    #     elsif search_option == "Purchase"
    #         add_drink(drink_answer)
    #         # new_drink = Drink.new(drink_answer, "some string", 7)
    #     else search_option == "Back"
    #         returned_drinks
    #     end
        
        
    
        
        

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