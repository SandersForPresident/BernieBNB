class AddDeletedAtToVisit < ActiveRecord::Migration
  def change
    add_column :visits, :deleted_at, :datetime
  end
end
