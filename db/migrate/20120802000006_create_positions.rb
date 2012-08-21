class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.integer :sport_id, :null => false
      t.string :name, :null => false
      t.string :abbrev
      t.timestamps
    end
  end
end