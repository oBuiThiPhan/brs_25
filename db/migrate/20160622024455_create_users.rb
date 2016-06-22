class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :password_confirmation
      t.string :avatar
      t.boolean :is_admin

      t.timestamps null: false
    end
    add_index :users, :email, unique: true
    add_column :users, :password_digest, :string
  end
end
