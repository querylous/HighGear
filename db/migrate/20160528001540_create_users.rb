class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :emp_no
      t.string :password_digest
      t.string :fname
      t.string :lname
      t.string :email

      t.timestamps null: false
    end
  end
end
