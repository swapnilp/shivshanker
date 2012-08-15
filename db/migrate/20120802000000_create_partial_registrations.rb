class CreatePartialRegistrations < ActiveRecord::Migration
  def change
    create_table :partial_registrations do |t|
      t.string :email, :null => false
      t.string :first_name
      t.string :last_name
      t.boolean :reminder_sent, :null => false, :default => false

      t.timestamps
    end

    add_index :partial_registrations, [:email], :unique => true
  end
end