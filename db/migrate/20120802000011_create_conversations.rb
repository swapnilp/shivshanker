class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :author_id, :null => false
      t.timestamps
    end

    add_index :conversations, :author_id

    create_table :conversation_visibilities do |t|
      t.integer :conversation_id, :null => false
      t.integer :user_id, :null => false
      t.integer :participants, :null => false
      t.boolean :unread, :null => false, :default => true
      t.boolean :hidden, :null => false, :default => false
      t.timestamps
    end

    add_index :conversation_visibilities, [:conversation_id, :user_id], :unique => true
    add_index :conversation_visibilities, [:user_id]

    create_table :conversation_messages do |t|
      t.integer :conversation_id, :null => false
      t.integer :author_id, :null => false
      t.text :text, :null => false
      t.timestamps
    end

    add_index :conversation_messages, [:conversation_id]
  end
end