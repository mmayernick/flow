require File.join(Rails.root, 'lib', 'authenticated_system')

class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from Recaptcha::RecaptchaError, :with => :recaptcha_error

  def recaptcha_error
    render text: "Please see the instructions on https://github.com/ambethia/recaptcha for setting up your recaptcha public and private keys."
  end

  def passes_captcha?
    verify_recaptcha
  end

  include AuthenticatedSystem

  def tweet(item)
    return unless Rails.env.production? && @item.tweetable?
    Twitter.update("#{truncate(item.title, :length => 100)} #{item_url(item)}")
  end

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
