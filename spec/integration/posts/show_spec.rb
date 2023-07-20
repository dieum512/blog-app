require 'rails_helper'

RSpec.describe 'Post Detail Section', type: :feature do
  before do
    @user = User.create(name: 'Mondol', photo: 'https://example.jpg',
                        bio: 'He is a software engineer from Bangladesh', posts_counter: 10)
    @post = Post.create(author: @user, title: 'test post', text: 'This is my first post', likes_counter: 15,
                        comments_counter: 10)
    @comment = Comment.create(post_id: @post.id, user_id: @user.id, text: 'test comment')
    visit user_post_path(@user, @post)
  end

  it 'Display the post\'s title.' do
    page.has_content?(@post.title)
  end

  it 'Display who wrote the post.' do
    page.has_content?(@post.author)
  end

  it 'Display how many comments it has.' do
    page.has_content?(@post.comments_counter)
  end

  it 'Display how many likes it has.' do
    page.has_content?(@post.likes_counter)
  end

  it 'Display the post body.' do
    page.has_content?(@post.text)
  end

  it 'Display the username of each commentor.' do
    page.has_content?(@comment.user.name)
  end

  it 'Display the comment each commentor left.' do
    page.has_content?(@comment.user.comments)
  end
end
