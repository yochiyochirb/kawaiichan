class RenameColumnUserIdToCreatedByIdInPosts < ActiveRecord::Migration[5.0]
  def change
    rename_column :posts, :user_id, :created_by_id
  end
end
