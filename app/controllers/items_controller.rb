class ItemsController < ApplicationController
  before_filter :login_required, :except => [:show, :index, :search, :category, :new, :create]
  before_filter :admin_required, :only => [:destroy]
  before_filter :permission_required, :only => [:edit, :update]

  # GET /items
  # GET /items.xml
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
      format.xml  { render :xml => @items }
      format.rss { render :layout => false }
      format.json { render :json => @items }
    end
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    @item = Item.find_by_id_or_name(params[:id])

    render_404 and return unless @item

    @title = @item.title

    @comment = Comment.new(params[:comment])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item }
      format.json { render :json => @item }
    end
  end

  # GET /items/new
  # GET /items/new.xml
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find_by_id_or_name(params[:id])
  end

  # POST /items
  # POST /items.xml
  def create
    @item = Item.new(params[:item])

    if logged_in?
      @item.user = current_user
    else
      @item.content = @item.content.gsub(/((<a\s+.*?href.+?\".*?\")([^\>]*?)>)/, '\2 rel="nofollow" \3>')
    end

    @item.url = URI::extract(@item.content).try(:first) if @item.url.blank?

    # FIXME remove this, because title required
    if @item.title.empty?
      @item.title = @item.content.gsub(/\<[^\>]+\>/, '')[0...40] + "..."
    end

    if ! logged_in? && ! passes_captcha?
      flash.now[:notice] = "Your item could not be posted. Did you get the CAPTCHA right?"
      render :action => 'new'
      return
    end

    respond_to do |format|
      if @item.save
        flash[:notice] = 'Item was successfully posted.'
        format.html { redirect_to(@item) }
        format.xml  { render :xml => @item, :status => :created, :location => @item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item ||= Item.find_by_id_or_name(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        flash[:notice] = 'Item was successfully updated.'
        format.html { redirect_to(@item) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item ||= Item.find_by_id_or_name(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(items_url) }
      format.xml  { head :ok }
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
      format.xml  { render :xml => @items }
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
