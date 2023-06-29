class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :author, foreign_key: { to_table: :users, column: :author_id }
      t.references :post, foreign_key: { to_table: :posts, column: :post_id }

      t.timestamps
    end

    add_index :likes, :author_id
    add_index :likes, :post_id
  end
end
