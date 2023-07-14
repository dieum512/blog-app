class PostsController < ApplicationController
  def index
    @users = User.find(params[:user_id])
    @posts = @users.posts
    @comments = Comment.where(post_id: @posts.pluck(:id))
  end

  def show
    @post = Post.find(params[:id])
    @users = @post.author
    @index = @users.posts.order(created_at: :asc).pluck(:id).index(@post.id)
  end
end
