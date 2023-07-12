require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe 'GET /users' do
    it 'renders the index template' do
      get '/users'
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
      expect(response.body).to include('List of users')
    end
  end

  describe 'GET /users/:user_id' do
    it 'renders the users by id' do
      user = User.create(id: 1, name: 'syed') 
      get '/users/1'
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
    end
  end
end