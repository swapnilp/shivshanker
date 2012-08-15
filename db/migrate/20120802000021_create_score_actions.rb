class CreateScoreActions < ActiveRecord::Migration
  def change
    create_table :score_actions do |t|
      t.integer :value, :null => false
      t.string :name, :unique => true, :null => false
      t.string :description
      t.string :href
    end
    add_index :score_actions, [:name, :value], :unique => true

    create_table :monthly_scores do |t|
      t.integer :user_id, :null => false
      t.integer :year, :null => false
      t.integer :month, :null => false
      t.integer :value, :null => false, :default => 0
    end
    add_index :monthly_scores, [:user_id, :year, :month, :value], :unique => true

    create_table :user_scores do |t|
      t.integer :user_id, :null => false
      t.integer :score_action_id, :null => false
      t.boolean :pending, :null => false, :default => true
      t.integer :value, :null => false
      t.datetime :created_at, :null => false
    end
    add_index :user_scores, [:user_id, :score_action_id]
    add_index :user_scores, [:user_id, :pending]
  end
end