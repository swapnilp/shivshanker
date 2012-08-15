class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.datetime :created_at, :null => false
      t.datetime :updated_at, :null => false
      t.datetime :edited_at
      t.integer :actor_id, :null => false
      t.string :actor_type, :null => false
      t.string :actor_display_name, :null => false
      t.integer :subject_id, :null => false
      t.string :subject_type, :null => false
      t.string :subject_display_name, :null => false
      t.integer :activity_id
      t.string :activity_type
      t.boolean :shared, :null => false, :default => false
      t.boolean :proxy_comments, :null => false, :default => false
      t.boolean :proxy_likes, :null => false, :default => false
      t.text :content, :null => false
      t.text :content_html, :null => false
      t.integer :comments_count, :null => false, :default => 0
    end
  end
end