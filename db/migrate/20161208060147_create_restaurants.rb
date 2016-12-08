class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.integer :store
      t.string :name
      t.integer :gm

      t.timestamps null: false
    end
  end
end
