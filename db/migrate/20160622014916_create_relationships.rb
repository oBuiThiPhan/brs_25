class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.string :followed_id
      t.string :integer

      t.timestamps null: false
    end
  end
end
