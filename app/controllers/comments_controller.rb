class CommentsController < ApplicationController
  # def new
  #   @comment = Comment.new
  #   @post = Post.find_by(id: params[:post_id])
  #   render :new
  # end
  def new
    @comment = Comment.new
    @post = Post.find_by(id: params[:post_id])
    render :new, locals: { comment: @comment, post: @post }
  end

  def create
    @user = @current_user
    @post = Post.find_by(id: params[:post_id])
    @comment = Comment.new(user_id: @user.id, post_id: @post.id, text: params[:comment][:text])
    if @comment.save
      redirect_to user_post_comments_path(@user, @post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end
end
