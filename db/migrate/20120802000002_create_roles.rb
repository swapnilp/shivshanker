class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name, :null => false
    end
    add_index :roles, :name, :unique => true

    create_table :roles_users, :id => false do |t|
      t.integer :role_id, :null => false
      t.integer :user_id, :null => false
    end
    add_index :roles_users, [:role_id, :user_id], :unique => true
  end
end