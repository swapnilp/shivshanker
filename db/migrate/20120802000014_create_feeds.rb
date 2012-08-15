class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feed_entries do |t|
      t.string :owner, :null => false
      t.string :name, :null => false
      t.integer :post_id, :null => false
      t.boolean :hidden, :null => false, :default => false
      t.string :iso8601, :null => false, :length => 30
    end

    add_index :feed_entries, [
      :owner, :name, :post_id, :hidden, :iso8601
    ], {
      :unique => true,
      :name => "idx_feed_entries"
    }
  end
end