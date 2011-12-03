class ItemsController < ApplicationController
  before_filter :login_required, :except => [:show, :index, :search, :new, :create, :url_images]
  before_filter :admin_required, :only => [:destroy]
  before_filter :permission_required, :only => [:edit, :update]

  def index
    @front_page = true
    @items_count = Item.count

    if params[:q]
      @items = Item.search(params[:q]).newest_first.includes(:user).paginate :page => params[:page]
    else
      @items = Item.newest_first.includes(:user).paginate :page => params[:page]
    end

    respond_to do |format|
      format.html # index.html.erb
      format.rss { render :layout => false }
      format.json { render :json => @items }
    end
  end

  def show
    @item = Item.find_by_id_or_name(params[:id])

    render_404 and return unless @item

    @title = @item.title

    @comment = Comment.new(params[:comment])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @item }
    end
  end

  def url_images
    url = params[:url]
    render :status => 404 and return if url.blank?

    acquirer = ImageAcquirer.new(url)
    @images = acquirer.get_images

    respond_to do |format|
      format.html
      format.json { render :json => @images}
    end
  end

  def new
    @item = Item.new
    @item.title = params[:t] unless params[:t].blank?
    @item.url = params[:u] unless params[:u].blank?

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @item = Item.find_by_id_or_name(params[:id])
  end

  def create
    @item = Item.new(params[:item])

    if logged_in?
      @item.user = current_user
    else
      @item.content = @item.content.gsub(/((<a\s+.*?href.+?\".*?\")([^\>]*?)>)/, '\2 rel="nofollow" \3>')
    end
    
    if !params[:image_url].blank? && params[:no_image].blank?
      @item.image = open(params[:image_url])
    end

    if !logged_in? && !passes_captcha?
      flash.now[:notice] = "Your item could not be posted. Did you get the CAPTCHA right?"
      render :action => 'new'
      return
    end

    respond_to do |format|
      if @item.save
        tweet(@item)
        flash[:notice] = 'Item was successfully posted.'
        format.html { redirect_to(@item) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @item ||= Item.find_by_id_or_name(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        flash[:notice] = 'Item was successfully updated.'
        format.html { redirect_to(@item) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @item ||= Item.find_by_id_or_name(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(items_url) }
      format.json { head :ok }
    end
  end

  def star
    @item = Item.find_by_id_or_name(params[:id])
    was_starred = current_user.star(@item)

    respond_to do |wants|
      wants.html { redirect_to :back }
      wants.js do
        if was_starred
          stars_count = @item.stars.size + 1
          render(:text => "#{stars_count} #{stars_count == 1 ? "star" : "stars"}")
        else
          head(:unprocessable_entity)
        end
      end
    end
  end

  def unstar
    @item     = Item.find_by_id_or_name(params[:id])
    was_unstarred = @star = current_user.unstar(@item)

    respond_to do |wants|
      wants.html { redirect_to :back }
      wants.js do
        if was_unstarred
          stars_count = @item.stars.size - 1
          render(:text => "#{stars_count} #{stars_count == 1 ? "star" : "stars"}")
        else
          head(:unprocessable_entity)
        end
      end
    end
  end

  protected

  def permission_required
    @item = Item.find_by_id_or_name(params[:id])
    (render_404 and return) unless @item
    (render_403 and return) unless @item.user_id == current_user.id || admin?
  end

end
