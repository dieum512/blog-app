require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it 'belongs to user' do
      association = described_class.reflect_on_association(:author)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:foreign_key]).to eq('author_id')
    end

    it 'belongs to post' do
      association = described_class.reflect_on_association(:post)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:foreign_key]).to eq('post_id')
    end
  end

  describe 'update posts counter' do
    user = User.create(name: 'Man', photo: 'photo', bio: 'bio', posts_counter: 0)
    post = Post.create(title: 'post', text: 'This is my post', author_id: user.id, comments_counter: 0,
                       likes_counter: 0)

    subject { described_class.create(post: post, user_id: user.id) }

    it 'posts comments count should increase' do
      expect(subject.post.likes_counter).to eq(post.likes_counter)
    end
  end
end
