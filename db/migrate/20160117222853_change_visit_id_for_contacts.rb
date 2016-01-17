class ChangeVisitIdForContacts < ActiveRecord::Migration
  def change
    rename_column :contacts, :visitor_id, :visit_id
  end
end
