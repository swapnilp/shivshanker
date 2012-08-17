class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :likable_id, :null => false
      t.string :likable_type, :null => false
      t.integer :user_id, :null => false
      t.integer :value, :null => false, :default => 1
      t.datetime :created_at, :null => false
    end
    add_index :likes, [:likable_id, :likable_type, :user_id], :unique => true
    add_index :likes, [:likable_id, :likable_type, :value], :unique => true
  end
end