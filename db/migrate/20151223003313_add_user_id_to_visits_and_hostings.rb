class AddUserIdToVisitsAndHostings < ActiveRecord::Migration
  def change
    add_column :visits, :user_id, :integer, null: false
    add_column :hostings, :user_id, :integer, null: false
  
    add_index :visits, :user_id
    add_index :hostings, :user_id
  end
end
