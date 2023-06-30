class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  after_create :update_post_comments_counter
  after_destroy :decrement_post_comment_counter

  def update_post_comments_counter
    post.update(comments_count: post.comments.count)
  end

  def decrement_post_comment_counter
    post.decrement!(:comments_count)
  end
end
