require 'rails_helper'

RSpec.describe 'Show Page', type: :feature do
  before(:each) do
    @user = User.create(name: 'Mondol', photo: 'https://example.jpg',
                        bio: 'He is a software engineer from Bangladesh', posts_counter: 10)
    @post1 = Post.create(title: 'test post-1', text: 'test text-1', comments_counter: 1,
                         likes_counter: 2, user_id: @user.id)
    @post2 = Post.create(title: 'test post-1', text: 'test text-1', comments_counter: 1,
                         likes_counter: 2, user_id: @user.id)
    @post3 = Post.create(title: 'test post-1', text: 'test text-1', comments_counter: 1,
                         likes_counter: 2, user_id: @user.id)
    @post4 = Post.create(title: 'test post-1', text: 'test text-1', comments_counter: 1,
                         likes_counter: 2, user_id: @user.id)

    visit user_path(@user)
  end

  it 'Display the user\'s profile picture.' do
    expect(page.html).to include(@user.photo)
  end

  it 'Display the user\'s username.' do
    expect(page).to have_content(@user.name)
  end

  it 'Display the number of posts the user has written.' do
    expect(page.html).to have_content(@user.posts_counter)
  end

  it 'Display the user\'s bio.' do
    page.has_content?(@user.bio)
  end

  it 'Display the user\'s first 3 posts.' do
    recent_posts = @user.recent_posts.limit(3)
    recent_posts.each do |post|
      expect(page).to have_content(post.title)
    end
  end

  it 'Display a button that lets me view all of a user\'s posts.' do
    page.has_button?('See all posts')
  end

  it 'Redirect to the user\'s post\'s index page when I clicking on see all posts.' do
    within('.see-posts') do
      click_link('See all posts')
    end
    expect(current_path).to eq(user_posts_path(@user))
  end
end
