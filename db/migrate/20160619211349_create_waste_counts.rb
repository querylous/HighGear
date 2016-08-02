class CreateWasteCounts < ActiveRecord::Migration
  def change
    create_table :waste_counts do |t|
      t.integer :count
      t.integer :food_id
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :waste_counts, :food_id
    add_index :waste_counts, :user_id 
  end
end
