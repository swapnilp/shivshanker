class CreateAthletes < ActiveRecord::Migration
  def change
    create_table :athletes do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :display_name
      t.integer :school_id, :null => false
      t.integer :final_year, :null => false
      t.integer :number
    end

    add_index :athletes, :user_id
    add_index :athletes, :school_id

    create_table :athlete_teams do |t|
      t.integer :athlete_id, :null => false
      t.integer :team_id, :null => false
      t.integer :season_id, :null => false
      t.boolean :active, :null => false, :default => false
    end

    add_index :athlete_teams, [:athlete_id, :team_id, :season_id]

    create_table :athlete_teams_positions, :id => false do |t|
      t.integer :athlete_team_id, :null => false
      t.integer :position_id, :null => false
    end
  end
end