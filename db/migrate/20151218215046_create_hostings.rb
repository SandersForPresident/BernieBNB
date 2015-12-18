class CreateHostings < ActiveRecord::Migration
  def change
    create_table :hostings do |t|
      t.string :zipcode, null: false
      t.integer :max_guests, null: false, default: 1
      t.float :latitude, null: false
      t.float :longitude, null: false

      t.timestamps null: false
    end
  end
end
