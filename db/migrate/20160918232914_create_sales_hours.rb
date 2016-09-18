class CreateSalesHours < ActiveRecord::Migration
  def change
    create_table :sales_hours do |t|

      t.timestamps null: false
    end
  end
end
