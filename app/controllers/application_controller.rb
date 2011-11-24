require File.join(Rails.root, 'lib', 'authenticated_system')

class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def help
    FlowHelper.instance
  end

  class FlowHelper
    include Singleton
    include ActionView::Helpers::TextHelper
    include ActionView::Helpers::SanitizeHelper
  end

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
    text = bare_content("#{item.title}: #{item.content}".gsub(/bq\. /, ''))
    Twitter.update("#{help.truncate(text, :length => 100)} #{item_url(item)}")
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
  
  def bare_content(contents)
    help.strip_tags(RedCloth.new(contents, [:filter_styles, :filter_classes, :filter_ids]).to_html)
  end
  
  def to_textile(contents)
	  html = RedCloth.new(contents, [:filter_styles, :filter_classes, :filter_ids]).to_html()
    help.sanitize(html, :tags => %w(a p code b strong i em blockquote ol ul li), :attributes => %w(href))
	end

  helper_method :site_config, :to_textile
end
