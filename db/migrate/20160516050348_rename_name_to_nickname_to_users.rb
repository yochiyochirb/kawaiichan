class RenameNameToNicknameToUsers < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :name, :nickname
  end
end
