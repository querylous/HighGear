class AddStoreToWasteCount < ActiveRecord::Migration
  def change
    add_column :waste_counts, :store, :integer
  end
end
