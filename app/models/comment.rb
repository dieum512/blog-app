class Comment < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :post, class_name: 'Post', foreign_key: 'post_id'
  after_create :update_post_comments_counter
  after_destroy :decrement_post_comment_counter

  # validates :text, presence: true
  # validates :user_id, presence: true

  def update_post_comments_counter
    post.update(comments_counter: post.comments.count)
  end

  def decrement_post_comment_counter
    post.decrement!(:comments_counter)
  end
end
