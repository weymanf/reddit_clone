class LinksController < ApplicationController
  before_filter :ensure_user_created, :only => [:edit, :update, :destroy]

  def new
    @link = Link.new
  end

  def create
    @link = current_user.links.new(link_params)

    if @link.save
      redirect_to link_url(@link)
    else
      flash.now[:errors] = @link.errors.full_messages
      render :new
    end
  end

  def edit
    @link = Link.find(params[:id])
    @subs = @link.subs
  end

  def update
    @link = Link.find(params[:id])

    ActiveRecord::Base.transaction do
      @link.links_subs.destroy_all
      @link.update_attributes(link_params)
    end
    if @link.errors.empty?
      redirect_to link_url(@link)
    else
      flash.now[:errors] = @link.errors.full_messages
      render :edit
    end

  end

  def show
    @link = Link.find(params[:id])
    @parent_comments = @link.parent_comments
    @comment_hash = @link.comments_by_parent_id
  end

  def destroy
    link = Link.find(params[:id])
    link.destroy
    redirect_to subs_url
  end

  def upvote
    @link = Link.find(params[:id])
    @link.user_votes.new(:user_id => current_user.id, :vote => 1)
    @link.save
    redirect_to link_url(@link)
  end

  def downvote
    @link = Link.find(params[:id])
    @link.user_votes.new(:user_id => current_user.id, :vote => -1)
    @link.save
    redirect_to link_url(@link)
  end


  def ensure_user_created
    @link = Link.find(params[:id])

    unless current_user == @link.user
      redirect_to link_url(@link)
    end
  end


  def link_params
    params.require(:link).permit(:title, :body, :url, :sub_ids => [])
  end
end
