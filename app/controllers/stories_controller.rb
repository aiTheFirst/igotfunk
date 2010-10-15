# This controller handles the
# viewing, creating, updating, and deleting
# of a single story for a regular user.
class StoriesController < ApplicationController
  
  layout 'main'
  
  # The user must be logged in to create, update, or destroy a story
  before_filter :login_required, :except => [:index], :message => 'test'
  
  # Make sure the user got to these methods by the post method
  # to ensure data doesn't get modified by accident
  # If the user does attempt to access one of these methods any other way
  # redirect them away from this page
  verify :method => :post, :only => [:create], 
         :redirect_to => :new_story_path
  
  # More checks to make sure the user only gets to important methods though post
  verify :method => :post, :only => [:update, :destroy],
         :redirect_to => { :action => :home_path }
  
  # Generates the data for the page displaying a single story
  def index
    # Get the story by the URL slug
    @story = Story.find_for_story_page(params[:name])
    #@story = Story.find_by_url_slug(params[:name])
    @username = User.find_user_login_by_id(@story.user_id)
    
    if (@video_code = @story.story_source.video_player_code) != nil
      while @video_code.match('<<#VIDEO_ID#>>')
        @video_code = @video_code.sub('<<#VIDEO_ID#>>', @story.url_video_id)
      end
    end
    
    @tags = @story.get_tag_link_list
    
    if @story.displayed_url == nil
      @story_url = @story.url
    else
      @story_url = @story.displayed_url
    end
    
    @user_ranking = Ranking.find :first, :conditions => ['story_id = ? and user_id = ?', @story_id, session[:current_user_id]], :select => 'score'
    @user_ranking = @user_ranking.score unless @user_ranking == nil
    
    #@tags = @story.get_tag_link_list
    
    # Use this method to pass the intense validation with creating/updating a story
    # since only the views are being incremented
    @story.views = @story.views + 1
    @story.update_attribute(:views, @story.views)
  end
  
  # Generates the data for the story creation page
  def new
    @story_categories = StoryCategory.find :all, :order => 'name'
    unless @story = flash[:story]
      @story = Story.new
    end
    
    @tags = flash[:tags] unless !flash[:tags]
  end
  
  # Creates a new story
  # This includes creating a new record for the
  # - Story
  # - Any tags that don't already exist
  # - Story/Tag links for the story
  def create
    @story = Story.new(params[:story])
    @story.user_id = session[:current_user_id]
    
    # Get the source id and add it to the new story
    domain = get_source(@story.url)
    @story.story_source_id = StorySource.save_and_get_source_id(domain)
    
    # Try to set the URL video ID
    @story.set_url_video_id
    
    # Attempt to save the story
    if @story.save
      # The story was saved successfully
      # Save the tags associated with the story
      save_tags(params[:tags], @story.id)
      
      # Redirect
      # flash[:notice] = 'Your story has been added.'
      
      redirect_to view_story_path(:name => @story.url_slug)
      # redirect_back_or('/')
    else
      # There was an error creating the story
      create_flash_for_story_form(@story, @tags, 'There was an error adding your story.')
      redirect_back_or('/')
    end
  end
  
  # Method that will eventually be used for the edit story page
  def edit
    unless @story = flash[:story]
      @story = Story.find_by_url_slug(params[:name])
    end
    
    @tags = flash[:tags] unless !(flash[:tags])
  end
  
  # Method that will eventually be used to update a story in the db
  def update
    @story = Story.find_by_url_slug(params[:name])
    @tags = params[:tags]
    if @story.update_attributes(params[:story])
      # Story was updated successfully, now update the tags
      save_tags(params[:tags], @story.id)
      
      flash[:notice] = "Story was successfully updated"
      redirect_back_or('/')
    else
      create_flash_for_story_form(@story, @tags, "There was an error updating the story")
      redirect_back_or('/')
    end
  end
  
  # Mehthod that will eventually be used to destroy a story
  def destroy
    @story = Story.find_by_url_slug(params[:name])
    @story.destroy unless @story == nil
    flash[:notice] = 'Story deleted.'
  end
  
  private
  
  # Method to create flash information for the story form
  ## Story - The story object from the form
  ## Tags - The tags field in the form
  ## Notice - Message to be displayed on the next page
  def create_flash_for_story_form(story, tags, notice)
    # The story
    flash[:story] = story
    
    # The tags that were to be associated with the story
    flash[:tags] = tags
    
    # A message that will be displayed to the user
    flash[:notice] = notice
  end
  
  # Saves tags and story tag links if they do not already exist
  def save_tags(tags, story_id)
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
  
  # Gets the source of a URL
  # Where the source refers to the domain and possible subdomains
  # i.e. Everything after 'http://www.' and before the next '/'.
  def get_source(url)
    # Remove the http:// part of the URL
    if (source = url.split(/^http[s]?:\/\//i)[1]) != nil
      
      #Remove the www part if it exists
      source = source.split(/^www./i)[1] unless source.match(/^www./i) == nil
      
      # Get the source
      source = source.split(/\//)[0]
      
      # If the source is a subdomain, remove the subdomain for now
      if((source.split('.')).length > 2)
        source = source.split('.', 2)[1]
      end
    end
    
    return source
  end
end