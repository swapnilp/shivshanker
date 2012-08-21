class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|
      t.string :name, :unique => true, :null => false
      t.string :gender_code, :null => false
      t.string :profile_picture_url
      t.timestamps
    end
  end
end