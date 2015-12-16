# require 'rails_helper'

# RSpec.describe ToursController, type: :controller do

#   let(:user) { FactoryGirl.create(:user) }

#   before(:each) do
#     allow(controller).to receive(:current_user).and_return(user)
#   end

#   context 'POST create' do

#     it 'generates a created response when a tour was built successfully' do
#       params = FactoryGirl.attributes_for(:tour)
#       post :create, params
#       expect(response).to have_http_status(:created)
#     end
#   end
  
#   context 'GET index' do
#   end

#   context 'GET show' do
#   end

#   context 'POST create' do
#   end

#   context 'PATCH update' do
#     let(:params) do
#       { :title => 'Johnny', :category => 'new' }
#     end

#     before(:each) do
#       @tour = create(:tour)
#       allow(controller).to receive(:current_user).and_return(@user)
#       patch :update, id: @tour.id, tour: params
#       @tour.reload
#     end

#     it { expect(@tour.title).to eq(params[:title]) }
#   end

#   context 'DELETE destroy' do
#   end
# end
