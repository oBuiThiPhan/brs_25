class CreateUserBooks < ActiveRecord::Migration
  def change
    create_table :user_books do |t|
      t.integer :user_id
      t.integer :book_id
      t.integer :mark_type

      t.timestamps null: false
    end
  end
end
