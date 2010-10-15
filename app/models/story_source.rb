class StorySource < ActiveRecord::Base
  has_many :stories
  has_many :story_source_id_filters
  has_many :story_source_filters
  
  # Saves the source of the URL if it is not already in the db
  ## Domain - The domain of the URL
  # Returns - The pk of the story source
  def self.save_and_get_source_id(domain)
    source_id = -1
    
    # If the source was not obtained, set the source id to -1 for now
    return source_id unless domain != nil
    
    if StorySource.exists?(:domain => domain)
      # The source already exists in the db, get its pk
      source_id = StorySource.find_by_domain(domain).id
    else
      story_source = StorySource.new(:name => domain, :domain => domain)
      if story_source.save!
        # If the new source saved correctly, get its pk
        source_id = StorySource.find_by_domain(domain).id
      end
    end
    
    # Return the pk
    return source_id
  end
end
