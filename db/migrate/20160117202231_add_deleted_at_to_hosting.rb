class AddDeletedAtToHosting < ActiveRecord::Migration
  def change
    add_column :hostings, :deleted_at, :datetime
  end
end
