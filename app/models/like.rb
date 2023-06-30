class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post
  after_create :update_post_likes_counter

  def update_post_likes_counter
    post.update(likes_count: post.likes.count)
  end
end