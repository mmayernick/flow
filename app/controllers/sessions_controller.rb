class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_login(params[:login]) || User.find_by_email(params[:login])
    if user && user.authenticate(params[:password])
      self.current_user = user
      redirect_to root_path, :notice => "Logged in!"
    else
      flash.now[:error] = "Invalid username or password"
      render "new"
    end
  end
  
  def destroy
    self.current_user = nil
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end
end
