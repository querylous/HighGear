class AddUserIdToSalesHour < ActiveRecord::Migration
  def change
    add_column :sales_hours, :user_id, :integer

    add_index :sales_hours, :user_id
  end
end
