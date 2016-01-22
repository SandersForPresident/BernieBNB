class AddStateAndCityToVisitAndHost < ActiveRecord::Migration
  def change
    add_column :visits, :city, :string
    add_column :visits, :state, :string
    add_column :hostings, :city, :string
    add_column :hostings, :state, :string
  end
end
