class UsersController < ApplicationController
  before_filter :admin_required, :except => [:new, :create, :recovery, :reset_password, :send_reset_password]
  
  def index
    @users = User.order('id DESC').limit(100)
  end

  def new
    @user = User.new
  end
  
  def send_reset_password
    user = User.find_by_email(params[:email])
    if user
      user.reset_password
      Notifications.password_reset(user).deliver
    end
    redirect_to root_path, :notice => "We have sent you an email with a password recovery link."
  end
  
  def recovery
    @user = User.find_by_password_reset_token(params[:reset_token])
    
    if @user
      self.current_user = @user
      @user.password_reset_token = nil
      @user.save!
    else
      redirect_to root_path
    end
  end
  
  def set_new_password
    if current_user
      logger.info "Logged in! Updating password to: #{params[:password]}"
      current_user.password = params[:password]
      current_user.save!
      redirect_to root_path, :notice => "Password successfully updated!"
    else
      redirect_to root_path
    end
  end
  
  def create
    @user = User.new(params[:user])
    unless passes_captcha?
      flash.now[:notice] = "Please check the captcha and try again."
      render :action => 'new'
      return
    end    

    if @user.save
      self.current_user = @user
      Notifications.registration(@user).deliver
      redirect_to root_url
      flash[:notice] = "Thanks for signing up! You have been logged in automagically!"
    else
      render :action => 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    @user.is_approved_for_feed = params[:user][:is_approved_for_feed] unless params[:user][:is_approved_for_feed].blank?
    
    if @user.save
      redirect_to :back, :notice => "User successfully updated."
    else
      redirect_to :back, :error => "Unable to update user."
    end
  end

  def destroy
    @user = User.find(params[:id])
    
    if @user.destroy
      redirect_to users_path
    else
      flash[:notice] = "unable to delete user #{@user.login}"
      redirect_to :back
    end
  end
end
