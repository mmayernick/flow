require File.join(Rails.root, 'lib', 'authenticated_system')

class ApplicationController < ActionController::Base
  protect_from_forgery
  
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
  
  def site_config
    configatron
  end
  
  helper_method :site_config
end
