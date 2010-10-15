# Controller taht handles the login/logout functionality of the site.
class SessionsController < ApplicationController

  layout 'main'
  
  verify :method => :post, :only => [:create], 
         :redirect_to => :login_path

  # This is the method for a login page, if there will be one specifically for logging in
  def new
    if logged_in?
      redirect_to home_path
    end
  end

  # Authenticates a user when logging in, if the name and password are valid
  def create
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        current_user.remember_me unless current_user.remember_token?
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      
      # Save the current user's ID and name so information can be accessed around the site
      session[:current_user_id] = current_user.id
      session[:current_user_name] = current_user.login
      
      # Eventually...
      # redirect_back_or('/')
      
      flash[:notice] = "Welcome back, #{current_user.login}!"
      
      redirect_to home_path
    else
      flash[:notice] = 'Username or password was incorrect'
      redirect_to login_path
    end
  end
  
  # Called when a user is logged out
  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_to login_path
  end
end
