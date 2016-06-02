class RemoveTypeFromFoods < ActiveRecord::Migration
  def change
    change_table :foods do |t|
      t.rename :type, :food_type
    end
  end
end
