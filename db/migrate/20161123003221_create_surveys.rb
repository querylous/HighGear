class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.integer :api_survey_id
      t.string  :name
      t.integer :store
      t.string  :api_user
      t.string  :api_user_key
      t.string  :fc_dt

      t.timestamps null: false
      
    end

      add_index :surveys, :store
      add_index :surveys, :fc_dt
      add_index :surveys, :api_survey_id

  end
end
