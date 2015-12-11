require 'rails_helper'

RSpec.describe ToursController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    allow(controller).to receive(:current_user).and_return(user)
  end

  context 'POST create' do

    # before(:each) do
    # @user = FactoryGirl.create(:user)
    # request.env['HTTP_AUTHORIZATION'] = @user.access_token
    # end

    it 'generates a created response when a tour was built successfully' do
      params = FactoryGirl.attributes_for(:tour)
      post :create, params
      binding.pry
      expect(response).to have_http_status(:created)
    end
  end
  
  context 'GET index' do
  end

  context 'GET show' do
  end

  context 'POST create' do
  end

  context 'PATCH update' do
  end

  context 'DELETE destroy' do
  end
end
