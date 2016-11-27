class AddFieldsToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :update, :boolean
    add_column :surveys, :questions, :json
  end
end
