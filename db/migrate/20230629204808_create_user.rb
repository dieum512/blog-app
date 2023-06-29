class CreateUser < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :photo, null: false, default: '', limit: 2048
      t.text :bio
      t.integer :posts_counter, default: 0

      t.timestamps
    end

  end
end
