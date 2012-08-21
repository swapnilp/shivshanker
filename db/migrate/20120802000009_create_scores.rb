class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :user_id, :null => false
      t.integer :game_id, :null => false
      t.integer :home_team_score, :null => false
      t.integer :away_team_score, :null => false
      t.timestamps
    end

    add_index :scores, [:game_id, :user_id], :unique => true
  end
end