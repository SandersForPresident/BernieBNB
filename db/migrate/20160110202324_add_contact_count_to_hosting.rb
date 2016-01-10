class AddContactCountToHosting < ActiveRecord::Migration
  def change
    add_column :hostings, :contact_count, :integer, default: 0, null: false
  end
end
