class AddHourToSalesHours < ActiveRecord::Migration
  def change
    add_column :sales_hours, :hour, :datetime
  end
end
