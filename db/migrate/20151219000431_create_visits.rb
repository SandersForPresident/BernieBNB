class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :zipcode, null: false
      t.integer :num_travelers, null: false, default: 1
      
      t.timestamps null: false
    end
  end
end
