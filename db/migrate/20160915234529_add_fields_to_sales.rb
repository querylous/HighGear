class AddFieldsToSales < ActiveRecord::Migration
  def change
    add_column :sales_hours, :projected_sales, :integer 
    add_column :sales_hours, :actual_sales, :integer 
    add_column :sales_hours, :projected_crew, :integer 
    add_column :sales_hours, :actual_crew, :integer 
  end
end
