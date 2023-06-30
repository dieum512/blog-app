class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  after_create :update_user_posts_counter
  after_destroy :decrement_user_posts_counter

  def five_recent_comments
    comments.include(:user).order(created_at: :desc).limit(5)
  end

  private

  def update_user_posts_counter
    author.increment!(:posts_counter)
  end

  def decrement_user_posts_counter
    author.decrement!(:post_counter)
  end
end
