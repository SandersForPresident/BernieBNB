class AddCommentToHosting < ActiveRecord::Migration
  def change
    add_column :hostings, :comment, :text
  end
end
