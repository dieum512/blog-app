class CreateComment < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: { to_table: :users, column: :author_id }
      t.references :post, foreign_key: { to_table: :posts, column: :post_id }
      t.text :text

      t.timestamps
    end

    add_index :comments, :author_id
    add_index :comments, :post_id
  end
end
