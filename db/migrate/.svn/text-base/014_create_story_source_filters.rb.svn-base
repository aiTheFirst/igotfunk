class CreateStorySourceFilters < ActiveRecord::Migration
  def self.up
    create_table :story_source_filters do |t|
      t.column :story_source_id, :int
      t.column :pre_regex, :string
      t.column :post_regex, :string
      t.timestamps
    end
    
    
  end

  def self.down
    drop_table :story_source_filters
  end
end
