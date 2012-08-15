class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :subscriber_id, :null => false
      t.integer :subscribable_id, :null => false
      t.string :subscribable_type, :null => false
    end

    add_index :subscriptions, [
      :subscriber_id, :subscribable_id, :subscribable_type
    ], {
      :unique => true,
      :name => "idx_subscriptions"
    }
  end
end