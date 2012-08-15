class CreateSupportContacts < ActiveRecord::Migration
  def change
    create_table :support_contacts do |t|
      t.integer :user_id
      t.string :email
      t.string :kind, :null => false
      t.boolean :handled, :null => false, :default => false
      t.integer :handler_id
      t.datetime :handled_at
      t.text :text, :null => false
    end
  end
end