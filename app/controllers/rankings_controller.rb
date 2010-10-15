# Controller for ranking stories using the funk-o-meter
class RankingsController < ApplicationController
  
  layout 'main'
  
  # The user must be logged in to create, update, or destroy a story
  before_filter :login_required, :except => [:index]
  
  # Data-modifications should only occur through forms
  verify :method => :post, :only => [:destroy],
         :redirect_to => { :action => '/' }

  def index
  end
  
  # Updates the ranking set by a user for a specific story
  # Currently stories can be ranked 0, 25, 50, 75, 100
  def create
    # Determine if a ranking exists for the current user and the story
    unless ( @ranking = Ranking.find_by_story_and_user(params[:story_id], session[:current_user_id]) ) != nil
      # Ranking doesn't exist, create it
      @ranking = Ranking.new
      @ranking.story_id = params[:story_id]
      @ranking.user_id = session[:current_user_id]
    end
    
    # Add or update the ranking score
    @ranking.score = params[:score]
    
    # Save or Update the ranking
    @ranking.save
    
    # Update the funk level for the story
    @story = Story.find_by_id(params[:story_id])
    @story.funk_level = Ranking.find_average_for_story(@story.id)
    @story.save
    
    redirect_to view_story_path(:name => @story.url_slug)
  end
  
  def update
    # Determine if a ranking exists for the current user and the story
    unless ( @ranking = Ranking.find_by_story_and_user(params[:story_id], session[:current_user_id]) ) != nil
      # Ranking doesn't exist, create it
      @ranking = Ranking.new
      @ranking.story_id = params[:story_id]
      @ranking.user_id = session[:current_user_id]
    end
    
    # Add or update the ranking score
    @ranking.score = params[:score]
    
    # Save or Update the ranking
    @ranking.save
    
    # Update the funk level for the story
    @story = Story.find_by_id(params[:story_id])
    @story.funk_level = Ranking.find_average_for_story(@story.id)
    @story.save
    
    render :nothing => true
  end
  
  # Removes a ranking for a specific user and story
  # Currently not used.
  def destroy
    @ranking.destroy unless @ranking == nil
    redirect_back_or('/')
  end
end