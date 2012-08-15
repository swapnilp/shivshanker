class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.integer :owner_id, :null => false
      t.string :file, :null => false
      t.string :caption
      t.integer :comments_count, :null => false, :default => 0
      t.integer :zencoder_output_id
      t.integer :zencoder_job_id
      t.boolean :processed, :null => false, :default => false
      t.timestamps
    end
  end
end
