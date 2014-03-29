class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    link = Link.find(params[:link_id])
    the_comment = link.comments.new(comment_params)
    the_comment.user_id = current_user.id
    the_comment.save

    flash[:errors] = the_comment.errors.full_messages
    redirect_to link_url(link)
  end


  private

  def comment_params
    params.require(:comment).permit(:body, :parent_comment_id)
  end



end
