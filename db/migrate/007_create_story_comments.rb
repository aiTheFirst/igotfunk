class CreateStoryComments < ActiveRecord::Migration
  def self.up
    create_table :story_comments do |t|
      t.column :user_id, :int
      t.column :story_id, :int
      t.column :description, :text
      t.timestamps
    end
  end

  def self.down
    drop_table :story_comments
  end
end
