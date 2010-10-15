# Controller for managing and viewing Users from the basic user's side
class UsersController < ApplicationController
  
  layout 'main'
  
  # The user must be logged in to update
  before_filter :login_required, :only => [:update]
  
  # Make sure the user got to these methods by the post method
  # to ensure data doesn't get modified by accident
  # If the user does attempt to access one of these methods any other way
  # redirect them away from this page
  verify :method => :post, :only => [:create], 
         :redirect_to => :signup_path
         
   verify :method => :post, :only => [:update], 
          :redirect_to => :home_path
         
  # Generates the information needed for a User Profile
  def index
    # Determine if the user name is set in the URL
    if params[:user_name] != nil
      # The user name is set, try to find it
      @user = User.find_by_login(params[:user_name])
      
      if @user != nil
        # This user name was valid, get the profile
        @profile = @user.user_profile
      
        # This is another profile view, increment the views and save it
        @profile.views = @profile.views + 1
        @profile.save
      else
        # The user name was invalid, redirect the user
        flash[:notice] = "The user '#{params[:user_name]}' does not exist."
        redirect_to home_path
      end
    end
  end
  
  # Generates the data needed for the signup page
  def new
    if @user = flash[:user]
      # The user was redirected to this page because of an error on signup page
      # Display the information that was entered again
      @profile = flash[:profile]
      
      ## Uncomment this if needed
      # Remove the password fields
      # @user.password = nil
      # @user.password_confirmation = nil
    else
      # The user is going to this page for the first time
      @user = User.new
      @profile = UserProfile.new
      @profile.gender = 'u'
    end
  end
  
  # Attempts to create a new user in the db
  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    @user.user_type = UserType.find_by_key('USER')
    @user.save
    if @user.errors.empty?
      
      # Now that the user has been added to the db, create the profile
      @user_profile = UserProfile.new(params[:profile])
      @user_profile.user_id = @user.id
      
      # Keep certain fields nil if they are empty
      @user_profile.location = nil unless @user_profile.location.strip != ''
      @user_profile.birthday = nil unless @user_profile.birthday != ''
      @user_profile.website = nil unless @user_profile.website.strip != ''
      @user_profile.save
      
      self.current_user = @user
      
      # Save the current user's ID and name so information can be accessed around the site
      session[:current_user_id] = current_user.id
      session[:current_user_name] = current_user.login
      session[:current_user_type] = current_user.user_type.key
      
      # Redirect the user to their new profile page
      flash[:notice] = "Welcome to igotfunk, #{current_user.login}!"
      redirect_to view_user_path(:user_name => session[:current_user_name])
    else
      # There was an error in saving the user
      # Return to the signup page
      flash[:user] = @user
      flash[:profile] = @user_profile
      redirect_to signup_path
    end
  end
  
  def edit
    if session[:current_user_name] == params[:user_name]
      @user = User.find_by_login(params[:user_name])
      @profile = @user.user_profile
    else
      # This is isn't the current user, therefore they cannot update the user
      # Take them to the view user page
      redirect_to view_user_path(:user_name => params[:user_name])
    end    
  end
  
  def update
    # Get the user's profile
    @profile = User.find_by_login(params[:user_name]).user_profile
    
    updated_profile = params[:profile]
    
    updated_profile[:location] = nil unless updated_profile[:location] != ''
    updated_profile[:birthday] = nil unless updated_profile[:birthday] != ''
    updated_profile[:website] = nil unless updated_profile[:website] != ''
    
    if @profile.update_attributes(updated_profile)
      redirect_to view_user_path(:user_name => params[:user_name])
    else
      
    end
  end
end
