# A Story Tag Link links a story to a tag
class StoryTagLink < ActiveRecord::Base
  
  # A tag and story should both be referenced
  belongs_to :tag
  belongs_to :story
  
  # Both the tag and story reference should exist for the link to exist
  validates_presence_of :tag_id, :story_id
  
  # Saves a story tag link if it does not already exist
  def self.save_link(story_id, tag_id)
    # Determine if the link between the story and the tag already exists
    if !(StoryTagLink.exists?(:story_id => story_id, :tag_id => tag_id))
      # The link doesn't exist yet create it and save it
      story_tag_link = StoryTagLink.new(:story_id => story_id, :tag_id => tag_id)
      story_tag_link.save!
    else 
      false
    end
  end
end
