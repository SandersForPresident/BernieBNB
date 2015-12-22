class AddFirstNameAndPhoneNumberToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :phone, :string
  end
end
