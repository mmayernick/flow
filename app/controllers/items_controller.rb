class ItemsController < ApplicationController
  before_filter :login_required, :except => [:show, :index, :search, :category, :new, :create]
  before_filter :admin_required, :only => [:destroy]
  before_filter :permission_required, :only => [:edit, :update]

  def index
    @front_page = true
    @items_count = Item.count

    if params[:q]
      @items = Item.search(params[:q]).paginate :page => params[:page]
    else
      @items = Item.front_page.paginate :page => params[:page]
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

  def new
    @item = Item.new
    @item.content = "So I *just* released this cool thing and blah blah blah..."
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

    @item.url = URI::extract(@item.content).try(:first) if @item.url.blank?
    
    if logged_in?
      @item.user = current_user
    else
      @item.content = @item.content.gsub(/((<a\s+.*?href.+?\".*?\")([^\>]*?)>)/, '\2 rel="nofollow" \3>')
    end

    # FIXME remove this, because title required
    if @item.title.empty?
      @item.title = @item.content.gsub(/\<[^\>]+\>/, '')[0...40] + "..."
    end

    if !logged_in? && !passes_captcha?
      flash.now[:notice] = "Your item could not be posted. Did you get the CAPTCHA right?"
      render :action => 'new'
      return
    end

    respond_to do |format|
      if @item.save
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

  def search
    @items_count = Item.count(:conditions => ['title LIKE ? OR tags LIKE ?', "%#{params[:id]}%", "%#{params[:id]}%"])
    @items = Item.paginate(:all, {:conditions => ['title LIKE ? OR tags LIKE ?', "%#{params[:id]}%", "%#{params[:id]}%"]})
    @noindex = true

    respond_to do |format|
      format.html
    end
  end

  def category
    @category = Category.find_by_name(params[:id])
    render_404 and return unless @category
    @items = Item.find_all_for_all_tags(@category.query.split(/\s/))
  end

  def recently
    @last_checked_at = current_user.last_checked_at
    conditions   = ['items.updated_at > ? or comments.created_at > ?', @last_checked_at, @last_checked_at]
    @items_count = current_user.starred_items.count(:conditions => conditions, :include => :comments)
    @items       = current_user.starred_items.paginate(:all, :conditions => conditions, :include => :comments, :page => params[:page])
    current_user.update_attribute :last_checked_at, Time.now
  end

  protected

  def permission_required
    @item = Item.find_by_id_or_name(params[:id])
    (render_404 and return) unless @item
    (render_403 and return) unless @item.user_id == current_user.id || admin?
  end

end
