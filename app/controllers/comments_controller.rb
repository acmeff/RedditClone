class CommentsController < ApplicationController
  before_action :require_login

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to post_url(@comment.post)
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to new_post_comment
    end
  end

  def new
    @comment = Comment.new
  end

  def show
    @comment = Comment.find(params[:id])
    @comments_by_parent_id = @comment.post.comments_by_parent_id
  end

  def upvote
    @comment = Comment.find(params[:id])
    @comment.votes << Vote.create(value: "+1")
    redirect_to :back
  end

  def downvote
    @comment = Comment.find(params[:id])
    @comment.votes << Vote.create(value: "-1")
    redirect_to :back

  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end
end
