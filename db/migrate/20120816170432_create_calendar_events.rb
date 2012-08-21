class CreateCalendarEvents < ActiveRecord::Migration
  def change
    create_table :calendar_events do |t|
      t.integer :creator_id, :null => false
      t.integer :owner_id, :null => false
      t.string :owner_type, :null => false
      t.datetime :datetime, :null => false
      t.string :title, :null => false
      t.string :location
      t.text :description, :null => false
      t.integer :comments_count, :null => false, :default => 0
    end

    create_table :calendar_event_invitations do |t|
      t.integer :calendar_event_id, :null => false
      t.integer :creator_id, :null => false
      t.integer :recipient_id, :null => false
      t.boolean :accepted
    end
  end
end
