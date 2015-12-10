require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
subject(:user) { FactoryGirl.create(:user) }
  
  it 'has a valid factory' do
    expect(user).to be_valid
  end

  context "columns" do
    it { is_expected.to have_db_column(:email).of_type(:string).with_options(unique: true, null: false) }
    it { is_expected.to have_db_column(:access_token).of_type(:string).with_options(unique: true, null: false) }
    it { is_expected.to have_db_column(:first_name).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:last_name).of_type(:string) }
    it { is_expected.to have_db_column(:avatar_file_name).of_type(:string) }
  end

  context 'associations' do
  end

  context 'validations' do

    it 'requires an email address' do
      expect(user).to validate_presence_of(:email)
    end

    it 'requires a unique email address' do
      expect(user).to validate_uniqueness_of(:email)
    end

    it 'requires a first name' do
      expect(user).to validate_presence_of(:first_name)
    end

    # it 'requires an access token' do
    #   expect(user).to validate_presence_of(:access_token)
    # end

    it 'requires a unique access token' do
      expect(user).to validate_uniqueness_of(:access_token)
    end

    it 'rejects mp3 as a valid avatar attachment type' do
      expect(build(:user, avatar_file_name: 'audio.mp3')).to_not be_valid
    end

    it 'accepts png as a valid avatar attachment type' do
      expect(build(:user, avatar_file_name: 'profile_picture.jpeg')).to be_valid
    end
  end
end

describe '#ensure_access_token!' do
  it 'ensures that users without an access token are assigned one' do
    user = build(:user, access_token: nil)
    user.ensure_access_token!
    access_token = user.access_token
    expect(access_token).to be_truthy
  end
end

describe '#favorite_tours' do
  subject(:user_with_tours) { FactoryGirl.create(:user_with_tours) }
  it 'ensures the method returns a user\'s favorite tours' do
    user = user_with_tours
    tour = user.tours.first
    tour.favorites.create(user_id: user.id)
    expect(user.favorite_tours).to exist
  end
end
