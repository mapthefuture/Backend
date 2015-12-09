require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  context "db" do
    context "indexes" do
      it { should have_db_index(:email).presence(true) }
      it { should have_db_index(:access_token).presence(true) }
      it { should have_db_index(:email).unique(true) }
      it { should have_db_index(:access_token).unique(true) }
      it { should have_db_index(:first_name).presence(true) }
    end

    context "columns" do
      it { should have_db_column(:email).of_type(:string).with_options(unique: true, null: false) }
      it { should have_db_column(:access_token).of_type(:string).with_options(unique: true, null: false) }
      it { should have_db_column(:first_name).of_type(:string).with_options(null: false) }
      it { should have_db_column(:last_name).of_type(:string) }
      it { should have_db_column(:avatar_file_name).of_type(:string) }
    end
  end

  context 'associations' do
  end

  context 'validations' do

    let(:user) { build(:user, access_token: "token", email: "a@b.c") }

    it 'requires an email address' do
      expect(:user).to validate_presence_of(:email)
    end

    it 'requires a unique email address' do
      expect(:user).to validate_uniqueness_of(:email)
    end

    it 'requires a first name' do
      expect(:user).to validate_presence_of(:email)
    end

    it 'requires an access token' do
      expect(:user).to validate_presence_of(:email)

    it 'rejects mp3 as a valid avatar attachment type' do
      expect(build(:user, avatar_file_name: 'audio.mp3')).to_not be_valid
    end

    it 'accepts png as a valid avatar attachment type' do
      expect(build(:user, avatar_file_name: 'profile_picture.jpeg')).to be_valid
    end
  end

describe '#ensure_access_token!' do

  it 'ensures that users without an access token are assigned one' do
    user = build(:user, access_token: nil)
    user.ensure_access_token!
    expect(user).to validate_presence_of(:access_token)
  end
end
