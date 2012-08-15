class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.integer :creator_id, :null => false
      t.integer :owner_id, :null => false
      t.string :owner_type, :null => false
      t.string :name, :null => false
      t.integer :thumbnail_id
      t.timestamps
    end

    add_index :galleries, [:owner_type, :owner_id]
  end
end