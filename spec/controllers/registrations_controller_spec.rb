require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do

  context 'POST create' do
    it 'sends status created when successful' do
      params = FactoryGirl.attributes_for(:user)
      post :create, params
      expect(response).to have_http_status(:created)
    end

    it 'sends status unprocessable when unsuccessful' do
      params = nil
      post :create, params
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'adds a user to the database' do
      params = FactoryGirl.attributes_for(:user)
      post :create, params
      expect(User.count).to eq(1)
    end

    it 'will not create a user without a valid email' do
      params = FactoryGirl.attributes_for(:user, email: nil)
      post :create, params
      expect(User.count).to eq(0)
    end

    it 'will not create a user without a password' do
      params = FactoryGirl.attributes_for(:user, password: nil)
      post :create, params
      expect(User.count).to eq(0)
    end

    it 'requires users to have unique email addresses' do
      params = FactoryGirl.attributes_for(:user, email: 'name@email.com')
      post :create, params
      expect(User.count).to eq(1)
      post :create, params
      expect(response).to have_http_status(:unprocessable_entity)
      expect(User.count).to eq(1)
    end

    # it 'only accepts permitted params' do
    #   params = { first_name: "John", last_name: "Doe", email: "name@email.com",
    #              password: "password", favorite_animal: "blue whale" }
    #   post :create, params
    #   binding.pry
    #   expect(response).to have_http_status(:unprocessable_entity)
    # end
  end

  context 'GET show' do
    let(:user) { FactoryGirl.create(:user) }

    it 'accepts a valid email/password combination' do
      params = { email: user.email, password: user.password }
      get :show, params
      expect(response).to have_http_status(:accepted)
    end

    it 'renders the jbuilder template when successful' do
      params = { email: user.email, password: user.password }
      get :show, params
      expect(response).to render_template('show.json.jbuilder')
    end

    it 'rejects an invalid email/password combination' do
      params = { email: user.email, password: nil }
      get :show, params
      expect(response).to have_http_status(:unauthorized)
    end

    # it 'renders json errors when unsuccessful' do
    #   params = { email: user.email, password: nil }
    #   get :show, params
    #   binding.pry
    #   expect(response).to include("error": "Invalid email or password.")
    # end

  end

  context 'PATCH update' do
    let(:user) { FactoryGirl.create(:user) }

    before(:each) do
      allow(controller).to receive(:current_user).and_return(user)
    end

    it 'sends status accepted when user is updated successfully' do
      params = FactoryGirl.attributes_for(:user)
      patch :update, params
      expect(response).to have_http_status(:accepted)
    end
  end
end
