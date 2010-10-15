# A tag is a descriptive word or words that is used to describe or search for a story
class Tag < ActiveRecord::Base
  
  # Tags can be linked to a story
  has_many :story_tag_links
  
  # Each tag name should be unique otherwise the one that already exists
  # should be used rather than recreated
  validates_uniqueness_of :name
  
  # Saves the parent tag for the tag name unless it already exists
  # Returns the id of the parent tag in either case
  def self.save_parent_tag(name)
    # Convert the name to lowercase
    name = name
    
    # Determine if the tag already exists
    if !(parent_id = Tag.find_by_name(name))
      # The tag doesn't exist, create it and get the name
      parent_tag = Tag.new(:name => name)
      parent_tag.save
      parent_id = parent_tag.id
    end
    
    return parent_id
  end
  
  def self.save_tags_and_story_links(tags, story_id)
    taglist = tags.split(',')
    for tag in taglist
      tag = tag.strip unless tag.strip == nil
      if !(Tag.exists?(:name => tag))
        # The tag doesn't exist. It must be created.
        new_tag = Tag.new(:name => tag)
        if new_tag.save!
          # Once the tag has been created, try to create the story tag link
          tag_id = Tag.find_by_name(tag).id
          StoryTagLink.save_link(story_id, tag_id)
        end
      else
        # The tag already exists, but might not be linked to the story
        tag_id = Tag.find_by_name(tag).id
        StoryTagLink.save_link(story_id, tag_id)
      end
    end
  end
  
  # Saves the tags if they do not already exist
  # Returns the id for each tag in the array passed to the method
  def self.save_and_get_ids(tags)
    tag_ids = Array.new
    # Get all of the tag ids
    for tag in Tag.find :all, :select => 'id', :conditions => ['', tags]
      
    end
  end
  
  # Gets the ids for all the tags in the array that exist
  def self.get_id_array(tags)
    tag_ids = Array.new
    tag_list = Tag.find :all, :select => 'id', :conditions => ['', tags]
    
    for tag in tag_list
      tag_ids
    end
    
    return tag_ids
  end
  
  # Saves all tags in the array that do not exist in the database
  def self.save_if_nonexistent(tags)
    for tag in tags
      tag = tag.strip unless tag.strip == nil
      if !(Tag.exists?(:name => tag))
        # The tag doesn't exist. It must be created.
        new_tag = Tag.new(:name => tag)
        new_tag.save!
      end
    end
  end
end