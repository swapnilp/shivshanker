class CreateGames < ActiveRecord::Migration
  def change
    create_table :games, :force => true do |t|
      t.integer :winner_id
      t.integer :winner_score
      t.integer :loser_id
      t.integer :loser_score
      t.integer :home_team_id, :null => false
      t.integer :home_team_score
      t.integer :away_team_id, :null => false
      t.integer :away_team_score
      t.datetime :datetime, :null => false
      t.integer :season_id, :null => false
      t.timestamps
    end

    add_index :games, [:home_team_id, :away_team_id, :datetime], :unique => true

    create_table :game_teams do |t|
      t.integer :game_id, :null => false
      t.integer :team_id, :null => false
      t.boolean :home, :null => false
      t.timestamps
    end

    add_index :game_teams, [:game_id, :team_id], :unique => true
    add_index :game_teams, [:game_id, :home], :unique => true
  end
end