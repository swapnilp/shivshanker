class CreateInvites < ActiveRecord::Migration
def change
    create_table :invites do |t|
      t.integer :user_id, :null => false
      t.string :name
      t.string :email, :null => false
      t.timestamps
    end
  end

end
