class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :owner_id, :null => false
      t.integer :gallery_id, :null => false
      t.string :file, :null => false
      t.string :caption
      t.integer :comments_count, :null => false, :default => 0
      t.timestamps
    end

    add_index :pictures, :gallery_id
  end
end