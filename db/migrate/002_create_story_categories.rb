class CreateStoryCategories < ActiveRecord::Migration
  def self.up
    create_table :story_categories do |t|
      t.column :name, :string
      t.column :slug, :string
      t.timestamps
    end
    
    StoryCategory.create :name => 'Funny', :slug => 'funny'
    StoryCategory.create :name => 'Politics', :slug => 'politics'
    StoryCategory.create :name => 'Music', :slug => 'music'
    StoryCategory.create :name => 'Film', :slug => 'film'
    StoryCategory.create :name => 'Weird', :slug => 'weird'
    StoryCategory.create :name => 'Living', :slug => 'living'
    StoryCategory.create :name => 'Reality', :slug => 'reality'
    StoryCategory.create :name => 'Sports', :slug => 'sports'
    StoryCategory.create :name => 'Geeky', :slug => 'geeky'
    StoryCategory.create :name => 'Money', :slug => 'money'
  end

  def self.down
    drop_table :story_categories
  end
end
