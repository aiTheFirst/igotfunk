class StoryCommentsController < ApplicationController
  
  layout 'main'
  
  # The user must be logged in to create, update, or destroy a story
  before_filter :login_required
  
  # Make sure the user got to these methods by the post method
  # to ensure data doesn't get modified by accident
  # If the user does attempt to access one of these methods any other way
  # redirect them away from this page
  verify :method => :post, 
         :redirect_to => :home_path
  
  def create
    @comment = StoryComment.new(params[:comment])
    @comment.story_id = params[:story_id]
    @comment.user_id = session[:current_user_id]
    
    @story = @comment.story
  end

  def edit
    @comment = StoryComment.find_by_id(params[:comment_id])
    
  end

  def destroy
    @comment = StoryComment.find_by_id(params[:comment_id])
    @comment.destroy unless @comment == nil
    flash[:notice] = 'Comment deleted.'
  end
end
