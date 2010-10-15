class CreateRankings < ActiveRecord::Migration
  def self.up
    create_table :rankings do |t|
      t.column :user_id, :int
      t.column :story_id, :int
      t.column :score, :int
      t.timestamps
    end
  end

  def self.down
    drop_table :rankings
  end
end
