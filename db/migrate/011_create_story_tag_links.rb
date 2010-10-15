class CreateStoryTagLinks < ActiveRecord::Migration
  def self.up
    create_table :story_tag_links do |t|
      t.column :story_id, :int
      t.column :tag_id, :int
      t.timestamps
    end
  end

  def self.down
    drop_table :story_tag_links
  end
end
