class CreateSalesHours < ActiveRecord::Migration
  def change
    create_table :sales_hours do |t|
      t.datetime :datetime
      t.integer :projected_sales
      t.integer :actual_sales
      t.integer :projected_vlh
      t.integer :actual_vlh
      t.integer :ttl 
      t.integer :store_number
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
