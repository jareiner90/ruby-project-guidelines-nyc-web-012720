class Drink < ActiveRecord::Base
    has_many :orders
    has_many, through :orders
end