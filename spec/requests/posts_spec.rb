require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /users/:user_id/posts' do
    it 'renders the index template' do
      get '/users/5/posts'
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
      expect(response.body).to include('List of posts')
    end
  end

  describe 'GET /users/:user_id/posts.:id' do
    it 'renders the show template' do
      get '/users/3/posts/12'
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
    end
  end
end