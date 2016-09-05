class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :user, index: true, null: false
      t.integer :post_id, null: false
      t.text :body, null: false

      t.timestamps
    end

    rename_column :comments, :user_id, :commented_by_id

    add_foreign_key :comments, :users, column: 'commented_by_id'
  end
end
