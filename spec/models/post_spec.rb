require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it 'Belongs to a user' do
      association = described_class.reflect_on_association(:author)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:foreign_key]).to eq('author_id')
    end

    it 'has many comments' do
      association = described_class.reflect_on_association(:comments)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:foreign_key]).to eq('post_id')
    end

    it 'has many likes' do
      association = described_class.reflect_on_association(:likes)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:foreign_key]).to eq('post_id')
    end
  end

  describe 'validations' do
    it 'should return false without title' do
      post = Post.create(text: 'This is lovely', author: @user)
      expect(post.valid?).to eq(false)
    end

    it 'should return false without text' do
      post = Post.create(title: 'This is lovely', author: @user)
      expect(post.valid?).to eq(false)
    end

    it 'should validate likes_counter as a non-negative integer' do
      post = Post.new(likes_counter: -1)
      post.valid?
      expect(post.errors[:likes_counter]).to include('must be an integer greater than or equal to zero')
    end

    it 'should validate comments_counter as a non-negative integer' do
      post = Post.new(comments_counter: -1)
      post.valid?
      expect(post.errors[:comments_counter]).to include('must be an integer greater than or equal to zero')
    end
  end

  describe 'recent_posts' do
    before(:example) do
      @user = User.create(name: 'John Doe', photo: 'Person Image', bio: 'I am a teacher', posts_counter: 0)
      @post = Post.create(title: 'My post', text: 'Post body', author: @user, comments_counter: 0, likes_counter: 0)
    end

    let!(:comment1) do
      Comment.create(text: 'Comment 1', user: @user, post: @post)
    end
    let!(:comment2) do
      Comment.create(text: 'Comment 1', user: @user, post: @post)
    end
    let!(:comment3) do
      Comment.create(text: 'Comment 3', user: @user, post: @post)
    end
    let!(:comment4) do
      Comment.create(text: 'Comment 4', user: @user, post: @post)
    end
    let!(:comment5) do
      Comment.create(text: 'Comment 5', user: @user, post: @post)
    end

    it 'should return last 3 photos' do
      expect(@post.recent_comments).to include(comment1, comment2, comment3, comment4, comment5)
    end
  end

  describe '#update_post_counter' do
    before(:example) do
      @user = User.create(name: 'John Doe', photo: 'Person Image', bio: 'I am a teacher', posts_counter: 0)
      @post = Post.create(title: 'My post', text: 'Post body', author: @user, comments_counter: 0, likes_counter: 0)
    end

    it 'increments the author\'s posts_counter' do
      expect { @post.update_post_counter }.to change { @user.reload.posts_counter }.by(1)
    end
  end
end
