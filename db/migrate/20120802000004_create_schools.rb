class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name, :null => false
      t.string :address, :null => false
      t.string :city, :null => false
      t.string :county, :null => false
      t.string :state, :null => false
      t.string :zip, :null => false
      t.string :mascot
      t.string :primary_color
      t.string :secondary_color
      t.decimal :latitude, :null => false, :precision => 10, :scale => 7
      t.decimal :longitude, :null => false, :precision => 10, :scale => 7
      t.string :timezone, :null => false
      t.timestamps
    end
  end
end