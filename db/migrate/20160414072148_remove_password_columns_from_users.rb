class RemovePasswordColumnsFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :crypted_password
    remove_column :users, :salt
  end
end
