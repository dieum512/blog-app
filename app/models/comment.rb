class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post
  after_create :update_post_comments_counter
  after_destroy :decrement_post_comment_counter

  validates :text, presence: true
  validates :user_id, presence: true

  def update_post_comments_counter
    post.update(comments_count: post.comments.count)
  end

  def decrement_post_comment_counter
    post.decrement!(:comments_count)
  end
end
