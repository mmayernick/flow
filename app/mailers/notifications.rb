class Notifications < ActionMailer::Base
  default from: "no-one@iosdevlinks.com"
  
  def registration(user)
    @user = user
    mail(:to => "aaron@brethorsting.com", :subject => "Registration on iOS Dev Links")
  end
  
  def password_reset(user)
    @user = user
    mail(:to => @user.email, :subject => "Reset your password")
  end
end
