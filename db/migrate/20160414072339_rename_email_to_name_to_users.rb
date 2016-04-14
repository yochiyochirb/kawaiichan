class RenameEmailToNameToUsers < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :email, :name
  end
end
