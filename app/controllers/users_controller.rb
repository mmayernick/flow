class UsersController < ApplicationController
  before_filter :admin_required, :except => [:new, :create]

  def new
    @user = User.new
  end

  def create
    cookies.delete :auth_token
    
    @user = User.new(params[:user])
    unless passes_captcha?
      flash.now[:notice] = "Please check the captcha and try again."
      render :action => 'new'
      return
    end    

    if @user.save
      self.current_user = @user
      redirect_to root_url
      flash[:notice] = "Thanks for signing up! You have been logged in automagically!"
    else
      render :action => 'new'
    end
  end
  
  def index
    @users = User.order('id DESC').limit(100)
  end

  def approve
    user = User.find(params[:id])
    user.approved_for_feed = 1
    user.save
    redirect_to :back
  end

  def disapprove
    user = User.find(params[:id])
    user.approved_for_feed = 0
    user.save
    redirect_to :back
  end
  
  def destroy
    return unless request.post?
    User.destroy(params[:id])
  end
end
