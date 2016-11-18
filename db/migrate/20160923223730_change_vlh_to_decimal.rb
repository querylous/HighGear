class ChangeVlhToDecimal < ActiveRecord::Migration
  def self.up
    change_table :sales_hours do |t|
      t.change :projected_vlh, :decimal, :precision => 3, :scale => 2
      t.change :actual_vlh, :decimal, :precision => 3, :scale => 2
    end
  end
  def self.down
    change_table :products do |t|
      t.change :projected_vlh, :integer
      t.change :actual_vlh, :integer
    end
  end
end
