class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :host_id, null: false
      t.integer :visitor_id, null: false

      t.timestamps null: false
    end

    add_index :contacts, [:host_id, :visitor_id], unique: true
  end
end
