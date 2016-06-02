class AddWrinToFoods < ActiveRecord::Migration
  def change
    add_column :foods, :wrin, :string
    add_index :foods, :wrin
  end
end
