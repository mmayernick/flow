class CommentsController < ApplicationController
  before_filter :admin_required, :except => [:create]
  before_filter :load_item
  
  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = Comment.new(params[:comment])
    @comment.item = @item
    
    if logged_in?
      @comment.user = current_user
    else
      @comment.byline = "Anonymous" if @comment.byline.blank?
      @comment.content = @comment.content.gsub(/((<a\s+.*?href.+?\".*?\")([^\>]*?)>)/, '\2 rel="nofollow" \3>')
      unless passes_captcha?
        flash[:notice] = "Your comment could not be posted. Scroll down, correct, and retry. Did you get the CAPTCHA right?"
        render :template => 'items/show'
        return
      end
    end

    respond_to do |format|
      if @comment.save
        flash[:notice] = 'Comment was successfully created.'
        format.html { redirect_to(@comment.item) }
      else
        flash.now[:notice] = "Your comment could not be posted. Scroll down, correct, and retry."
        format.html { render :template => 'items/show' }
      end
    end
  end

  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Comment was successfully updated.'
        format.html { redirect_to(@item) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(@item) }
    end
  end
  
  private
    def load_item
      @item = Item.find(params[:item_id])
    end
end
