class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :name
      t.decimal :price
      t.string :type
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :foods, :users
  end
end
