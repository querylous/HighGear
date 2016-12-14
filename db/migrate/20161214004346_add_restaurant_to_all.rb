class AddRestaurantToAll < ActiveRecord::Migration
  def change
    add_column :responses, :restaurant_id, :integer
    add_column :waste_counts, :restaurant_id, :integer
    add_column :sales_hours, :restaurant_id, :integer
    add_column :surveys, :restaurant_id, :integer
  end
end
