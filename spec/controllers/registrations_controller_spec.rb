require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do

  before(:each) do
    allow(controller).to receive(:current_user).and_return(:user)
  end

    describe 'POST create' do
      context 'validate successful requests'do 
        let(:params) { FactoryGirl.attributes_for(:user) }

        before(:each) do
          post :create, user: params
        end

        it { expect(response).to have_http_status(:created) }
        it { expect(User.count).to eq(1) }
      end

      context 'reject invalid requests' do
        let(:params) { FactoryGirl.attributes_for(:user, email: nil) }

        before(:each) do
          post :create, user: params
        end

        it { expect(response).to have_http_status(:unprocessable_entity) }
        it { expect(User.count).to eq(0) }
        it 'requires users to have unique email addresses' do
          FactoryGirl.create(:user)
          expect(User.count).to eq(1)
          post :create, user: params
          expect(response).to have_http_status(:unprocessable_entity)
          expect(User.count).to eq(1)
        end
      end
    end

  describe 'GET show' do
    let(:user) { FactoryGirl.create(:user) }

    context 'accept valid requests' do

      before(:each) do 
        get :show, email: user.email, password: user.password
      end

      it { expect(response).to have_http_status(:accepted) }
      it { expect(response).to render_template('show.json.jbuilder') }
    end

    context 'reject invalid requests' do
      
      before(:each) do 
        get :show, email: user.email, password: nil 
      end

      it { expect(response).to have_http_status(:unauthorized) }
    end
  end

  describe 'PATCH update' do
    let(:params) do
      { :first_name => 'Johnny', :email => 'Johnny@email.com' }
    end

    before(:each) do
      @user = create(:user)
      allow(controller).to receive(:current_user).and_return(@user)
      patch :update, id: @user, user: params
      @user.reload
    end

    it { expect(@user.first_name).to eq(params[:first_name]) }
    it { expect(@user.email).to eq(params[:email]) }
    it { expect(response).to have_http_status(:accepted) }
    it { expect(response).to render_template('update.json.jbuilder') }
  end

  describe 'DELETE destroy' do
    let(:user) { FactoryGirl.create(:user) }

    context 'accept valid requests' do

      before(:each) do
        delete :destroy, email: user.email, password: user.password
      end
      
      it { expect(User.count).to eq(0) }
      it { expect(response).to have_http_status(:accepted) }
    end

    context 'reject invalid requests' do
      
      before(:each) do
        delete :destroy, email: user.email, password: nil
      end

      it { expect(User.count).to eq(1) }
      it { expect(response).to have_http_status(:unauthorized) }
    end
  end
end
