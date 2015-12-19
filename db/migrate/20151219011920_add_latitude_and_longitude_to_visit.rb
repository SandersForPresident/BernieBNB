class AddLatitudeAndLongitudeToVisit < ActiveRecord::Migration
  def change
    add_column :visits, :latitude, :float, null: false
    add_column :visits, :longitude, :float, null: false
  end
end
