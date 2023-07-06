# require 'rails_helper'

# RSpec.describe Comment, type: :model do
#   describe 'associations' do
#     it 'belongs to a user' do
#       user = User.new
#       comment = Comment.new(user: user)
#       expect(comment.user).to eq(user)
#     end

#     it 'belongs to a post' do
#       post = Post.new
#       comment = Comment.new(post: post)
#       expect(comment.post).to eq(post)
#     end
#   end

#   describe 'validations' do
#     it 'requires text to be present' do
#       comment = Comment.new
#       comment.valid?
#       expect(comment.errors[:text]).to include("can't be blank")
#     end
#   end

#   describe 'update posts counter' do
#     user = User.create(name: 'Man', photo: 'photo', bio: 'bio', posts_counter: 0)
#     post = Post.create(title: 'post', text: 'This is my post', author_id: user.id, comments_counter: 0,
#                        likes_counter: 0)

#     subject { described_class.create(text: 'My comment', post: post, user_id: user.id) }

#     it 'posts comments count should increase' do
#       expect(subject.post.comments_counter).to eq(post.comments_counter)
#     end
#   end
# end
