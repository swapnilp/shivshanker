class CreateNetworks < ActiveRecord::Migration
  def change
    create_table :networks do |t|
      t.string :name, :null => false
    end

    create_table :networks_users do |t|
      t.integer :network_id, :null => false
      t.integer :user_id, :null => false
    end
    add_index :networks_users, [:network_id, :user_id], :unique => true

    create_table :school_networks do |t|
      t.integer :network_id, :null => false
      t.integer :school_id, :null => false
      t.string :network_type, :null => false
    end
    add_index :school_networks,
      [:network_id, :school_id, :network_type],
      :name => :idx_school_networks, :unique => true

    create_table :sport_networks do |t|
      t.integer :network_id, :null => false
      t.integer :sport_id, :null => false
      t.string :network_type, :null => false
    end
    add_index :sport_networks,
      [:network_id, :sport_id, :network_type],
      :name => :idx_sport_networks, :unique => true

    create_table :school_sport_networks do |t|
      t.integer :network_id, :null => false
      t.integer :school_id, :null => false
      t.integer :sport_id, :null => false
      t.string :network_type, :null => false
    end
    add_index :school_sport_networks,
      [:network_id, :school_id, :sport_id, :network_type],
      :name => :idx_school_sport_networks, :unique => true
  end
end
