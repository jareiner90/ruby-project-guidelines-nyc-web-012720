class CreateUserTable < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name 
      t.integer :age
      t.integer :money
    end 
  end
end
