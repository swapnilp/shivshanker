class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :author_id, :null => false
      t.string :commentable_type, :null => false
      t.integer :commentable_id, :null => false
      t.datetime :created_at
      t.datetime :updated_at
      t.datetime :edited_at
      t.text :content, :null => false
      t.text :content_html, :null => false
    end

    add_index :comments, [:commentable_type, :commentable_id]
  end
end