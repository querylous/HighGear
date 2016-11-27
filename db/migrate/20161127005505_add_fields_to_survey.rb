class AddFieldsToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :updateable, :boolean, :default => false
    add_column :surveys, :questions, :json, :default => {}
  end
end
