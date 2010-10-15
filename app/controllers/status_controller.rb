class StatusController < ApplicationController

  # Data-modifications should only occur through forms
  verify :method => :post, :only => [:create, :destroy],
         :redirect_to => { :action => '/' }
  
  # Method to show the current logged user's current status
  # This is currently unused.
  def index
    # Get the current user's current status
    @status = Status.find_latest_for_user(session[:current_user_id])
  end
  
  # Lets a user update their current status
  def new
    @status = Status.find_latest_for_user(session[:current_user_id])
    @username = session[:current_user_name]
  end
  
  # Updates the current logged user's status by creating a new status record
  def create
    @status = Status.new(params[:status])
    @status.user_id = session[:current_user_id]
    
    if @status.save
      flash[:notice] = 'Status has been updated'
      redirect_back_or('/')
    else
      flash[:notice] = 'Error(s) updating status.'
      redirect_back_or('/')
    end
  end
  
  # Allows a user to remove a status
  def destroy
    @status = Status.find_by_id(params[:status_id])
    @status.destroy
    flash[:notice] = 'Status has been removed'
  end
end
