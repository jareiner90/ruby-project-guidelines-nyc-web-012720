class CreateDrinkTable < ActiveRecord::Migration[5.0]
  def change
    create_table :drinks do |t|
      t.string :name 
      t.string :ingridents
    end 
  end
end
