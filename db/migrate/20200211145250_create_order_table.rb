class CreateOrderTable < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.integer :user 
      t.integer :drink
      t.integer :total
    end 
  end
end
