class CreateGroupUsers < ActiveRecord::Migration
  def change
    create_table :group_users do |t|
      t.references :group, :null => false
      t.references :users, :null => false
      t.timestamps
    end
  end
end
