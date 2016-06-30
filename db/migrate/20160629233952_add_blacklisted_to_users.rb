class AddBlacklistedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :blacklisted, :boolean, default: false
  end
end
