class ChangeDetailsHostingsAndContacts < ActiveRecord::Migration
  def change
    rename_column :hostings, :user_id, :host_id
    rename_column :contacts, :host_id, :hosting_id
  end
end
