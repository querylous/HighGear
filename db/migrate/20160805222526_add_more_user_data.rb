class AddMoreUserData < ActiveRecord::Migration
  def change
    add_column :users, :store_number, :integer
  end
end
