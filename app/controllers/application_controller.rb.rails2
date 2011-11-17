# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '????? you'll need to sort this out yourself!'
  
  def passes_captcha?
    params[:captcha] && Digest::SHA1.hexdigest(params[:captcha].upcase.chomp)[0..5] == params[:captcha_guide]
  end
  
  include AuthenticatedSystem
  
  def render_404
    render :status => 404, :text => '404 Not Found'
  end
  
  def render_403
    render :status => 403, :text => '403 Forbidden'
  end
  
  def config
    configatron
  end
  
  helper_method :config
  
end
