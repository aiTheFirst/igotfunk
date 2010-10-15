class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      # The ID of the user that created this story
      t.column :user_id, :int
      
      # The category associated with this story
      t.column :story_category_id, :int
      
      # The ID of the source (i.e. Youtube) of the video
      t.column :story_source_id, :int
      
      # The name of the video entered by the user
      t.column :name, :string, :limit => 200
      
      # The URL slug used to find the story
      t.column :url_slug, :string, :limit => 250
      
      # The exact URL that the user submitted which might contain unneeded parameters
      # and also might be localised (i.e. youtube), this is saved incase there is a need to
      # revert from the displayed URLs
      t.column :url, :string, :limit => 500
      
      # The URL displayed on the site, without any of the unneed parameters or localisation
      t.column :displayed_url, :string, :limit => 500
      
      # The ID of the video on the source it comes from
      t.column :url_video_id, :string
      
      # A description of the video entered by the user that submitted it
      t.column :description, :text
      
      # The number of comments on the video
      t.column :comment_count, :int, :default => 0
      t.column :funks, :int, :default => 0
      
      # The number of views the video has
      t.column :views, :int, :default => 0
      
      t.column :funk_level, :int, :default => nil
      t.timestamps
    end
  end

  def self.down
    drop_table :stories
  end
end
