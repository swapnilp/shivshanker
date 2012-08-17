class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.string :name, :null => false
      t.text :html_banner
      t.text :description
      t.text :terms
      t.boolean :published, :null => false, :default => false
      t.binary :criteria_blob
      t.string :contest_type, :null => false

      t.datetime :starting
      t.datetime :ending
      t.datetime :entry_deadline
    end

    create_table :contest_users do |t|
      t.integer :contest_id, :null => false
      t.integer :user_id, :null => false
      t.boolean :eligible_cache, :null => false, :default => false
      t.boolean :participated, :null => false, :default => false
    end
    add_index :contest_users, [:contest_id, :user_id], :unique => true

    create_table :picture_contests do |t|
      t.integer :contest_id, :null => false, :unique => true
    end

    create_table :picture_contest_entries do |t|
      t.integer :picture_contest_id, :null => false
      t.integer :picture_id, :null => false
      t.integer :likes_cache, :null => false, :default => 0
      t.timestamps
    end
    add_index :picture_contest_entries,
      [:picture_contest_id, :picture_id],
      {:name => :idx_picture_contest_entries, :unique => true}

    create_table :signup_contests do |t|
      t.integer :contest_id, :null => false, :unique => true
    end

    create_table :signup_contest_schools do |t|
      t.integer :signup_contest_id, :null => false
      t.integer :school_id, :null => false
      t.timestamps
    end
    add_index :signup_contest_schools,
      [:signup_contest_id, :school_id],
      { :unique => true, :name => :idx_signup_contest_schools }
  end
end