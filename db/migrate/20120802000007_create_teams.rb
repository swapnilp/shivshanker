class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :school_id, :null => false
      t.integer :sport_id, :null => false
      t.string  :level, :null => false
      t.string  :gender, :null => false
      t.timestamps
    end

    add_index :teams, [:school_id, :sport_id, :level, :gender], :unique => true
  end
end