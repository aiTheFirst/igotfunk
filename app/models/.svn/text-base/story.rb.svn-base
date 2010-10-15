require 'validates_uri_existence_of'

class Story < ActiveRecord::Base
  
  acts_as_slugable :source_column => :name, :target_column => :url_slug
  
  belongs_to :user
  belongs_to :story_category
  belongs_to :story_source
  has_many :story_comments
  has_many :rankings
  has_many :story_tag_links
  
  validates_presence_of :name, :url, :story_category_id, :message => 'This is a required field.'
  validates_uri_existence_of :url, 
                             :with => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix, 
                             :message => 'This must be a valid URL.'
  
  def validate_on_create
   if self.url_video_id == nil
     # Validate that no existing stories have the same URL as this story
     if Story.exists?(:url => self.url)
       # Add an error
       self.errors.add_to_base("URL is taken")
     end
   else
     # Validate that no existing stories have the same video ID for the same source

     # Determine if any existing URLs start with the test URL above
     # if this is true add an error
     if Story.exists?(['story_source_id = ? and url_video_id = ?', self.story_source_id, self.url_video_id])
       self.errors.add_to_base("URL is taken")
     end
   end
  end
  
  # Recalculates the funk_count column of the story based on the rows associated with the story
  # in the Rankings table
  def recalculate_average_ranking
    self.funk_count = Ranking.find_average_ranking_by_story(self.id)
  end
  
  # Filters the URL of the Story to get the ID on the site it is coming from
  def set_url_video_id
    # Get the URL and put in this variable that will be filtered
    # down to the Video ID
    url_video_id = self.url
    
    # Remove the http:// part of the URL
    if (url_video_id = url_video_id.split(/^http[s]?:\/\//i)[1]) != nil
      
      #Remove the www part if it exists
      url_video_id = url_video_id.split(/^www./i)[1] unless url_video_id.match(/^www./i) == nil
      
      # Go through each of the filters for the source of this story and
      # find one that will return the ID
      for filter in self.story_source.story_source_id_filters
        
        # Determine if this filter is usable for the URL provided
        if url_video_id.match(/^#{filter.pre_id_regex}/i) != nil
          # Remove the first part of the URL
          url_video_id = url_video_id.split(filter.pre_id_url)[1]
          
          # Remove the end of the URL
          url_video_id = url_video_id.split(filter.post_id_url)[0]
          
          # Set the ID and return it
          self.url_video_id = url_video_id
          return url_video_id
        end
      end
    end
    
    # The ID could not be found
    # Return nil and don't set the ID
    return nil
  end
  
  # Find the top videos based on funk level
  def self.find_top_funked(limit)
    Story.find :all, :limit => limit, :order => 'funk_level DESC'
  end
  
  # Find the top video based on number of views
  def self.find_most_viewed(limit)
    Story.find :all, :limit => limit, :order => 'views DESC'
  end
  
  # Find the top videos based on the number of funks
  def self.find_most_funked(limit)
    Story.find :all, :limit => limit, :order => 'funks DESC'
  end
  
  # Gets all of the tags currently associated with a story and displays them with links
  def get_tag_link_list
    story_tag_links = StoryTagLink.find :all, 
                                        :select => 'id', 
                                        :conditions => ['story_id = ?', self.id]
    
    if story_tag_links.length > 0 
      # Tags for this story exist, get the tags
      tags = StoryTagLink.find_by_sql ['SELECT tags.name AS name FROM stories LEFT JOIN story_tag_links ON story_tag_links.story_id = stories.id LEFT JOIN tags ON tags.id = story_tag_links.tag_id WHERE stories.id = ?', self.id]

      tag_links = Array.new

      for tag in tags
        tag_links.push '<a href="#">' + tag.name + '</a>'
      end

      tag_link_list = tag_links * ', '
    else
      tag_link_list = ''
    end
    
    return tag_link_list
  end
  
  def self.find_for_story_page(url_slug)
    @story = Story.find :first, 
                        :include => [:story_source, :story_comments],
                        :conditions => ['url_slug = ?', url_slug]
  end
  
  def self.find_for_category_page(category_id, page, per_page)
    paginate :page => page, 
             :per_page => per_page, 
             :conditions => ['story_category_id = ?', category_id], 
             :order => 'created_at DESC'
  end
end
