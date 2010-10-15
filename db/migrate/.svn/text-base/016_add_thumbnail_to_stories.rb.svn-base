class AddThumbnailToStories < ActiveRecord::Migration
  def self.up
    add_column :story_sources, :thumbnail_link ,:string
    
    story_source = StorySource.find_by_domain('youtube.com')
    story_source.thumbnail_link = "http://img.youtube.com/vi/<<#VIDEO_ID#>>/0.jpg"
    story_source.save!
    
    story_source = StorySource.find_by_domain('metacafe.com')
    story_source.thumbnail_link = "http://www.metacafe.com/thumb/<<#VIDEO_ID#>>.jpg"
    story_source.save!
  end

  def self.down
   remove_column :story_sources, :thumbnail_link ,:string
  end
end
