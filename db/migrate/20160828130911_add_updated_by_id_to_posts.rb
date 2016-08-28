class AddUpdatedByIdToPosts < ActiveRecord::Migration[5.0]
  def change
    add_reference :posts, :updated_by, references: :users, index: true
    add_foreign_key :posts, :users, column: :updated_by_id
  end
end
