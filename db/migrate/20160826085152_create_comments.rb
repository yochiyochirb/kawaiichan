class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :commented_by, index: true, null: false, foreign_key: { to_table: :users }
      t.integer :post_id, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
