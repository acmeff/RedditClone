class PostsController < ApplicationController
  before_action :ensure_author, only: [:update, :edit]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to new_post_url
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def ensure_author
    unless current_user.posts.where(id: params[:id]).exists?
      redirect_to post_url(Post.find(params[:id]))
      flash[:errors] = ["Only an author can edit a post"]
    end
  end

  def update
    post = Post.find(params[:id])
    if post.update_attributes(post_params)
      redirect_to post_url(post)
    else
      flash[:errors] = post.errors.full_messages
      redirect_to post_url(post)
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments_by_parent_id = @post.comments_by_parent_id
  end

  def destroy
  end

  def upvote
    @post = Post.find(params[:id])
    @post.votes << Vote.create(value: "+1")
    redirect_to :back
  end

  def downvote
    @post = Post.find(params[:id])
    @post.votes << Vote.create(value: "-1")
    redirect_to :back
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end
