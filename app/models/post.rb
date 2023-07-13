class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, class_name: 'Comment', foreign_key: 'post_id'
  has_many :likes, foreign_key: 'post_id'

  after_create :update_user_posts_counter
  after_destroy :decrement_user_posts_counter

  validates :title, presence: true, length: { maximum: 250 }
  validates :text, presence: true

  validates :likes_counter,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0,
              message: 'must be an integer greater than or equal to zero'
            }, allow_nil: true
            # on: :create
  validates :comments_counter,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0,
              message: 'must be an integer greater than or equal to zero'
            }, allow_nil: true
            # on: :create

  def five_recent_comments
    comments.includes(:user).order(created_at: :desc).limit(5)
  end

  private

  def update_user_posts_counter
    author.increment!(:posts_counter)
  end

  def decrement_user_posts_counter
    author.decrement!(:posts_counter)
  end
end
