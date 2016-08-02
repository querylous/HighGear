class AddSortOrderToFoods < ActiveRecord::Migration
  def change
    add_column :foods, :sort_order, :integer
  end
end
