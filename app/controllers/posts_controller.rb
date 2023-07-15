class PostsController < ApplicationController
  def index
    @users = User.find(params[:user_id])
    @posts = @users.posts
    @comments = Comment.where(post_id: @posts.pluck(:id))
    @comments = Comment.all
  end

  def show
    @post = Post.find(params[:id])
    @users = @post.author
    @index = @users.posts.order(created_at: :asc).pluck(:id).index(@post.id)
    @comment = Comment.where(post_id: params[:id])
  end

  def new
    @user = @current_user
    @post = Post.new
    render :new
  end

  def create
    @user = @current_user
    @post = Post.new(post_params)
    @post.user_id = @user.id

    if @post.save
      flash[:success] = 'Post successfully created'
      redirect_to user_posts_url(@post.user_id)
    else
      flash[:alert] = 'Post could not be created'
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text).merge(user_id: @user.id)
  end
end
