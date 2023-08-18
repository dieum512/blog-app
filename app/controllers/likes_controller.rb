class LikesController < ApplicationController
  def create
    @post = params[:post_id]
    @user = @current_user
    @like = Like.new(author: @user, post_id: @post)
    if @like.save
      flash[:success] = 'You liked this post'
    else
      flash[:alert] = 'You cannot like this post'
    end

    redirect_to user_post_path(@user.id, @post)
  end
end
