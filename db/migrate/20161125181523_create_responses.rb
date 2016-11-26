class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :survey_id
      t.integer :user_id
      t.integer :response_id
      t.integer :store
      t.json   :answers, null: false, default: '{}' 


      t.timestamps null: false
    end
 
    add_index :responses, :survey_id
    add_index :responses, :response_id 
    add_index :responses, :id
  end
end
