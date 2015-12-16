require 'rails_helper'
require 'spec_helper'

RSpec.describe Tour, type: :model do

  it 'has a valid factory' do
    expect(build(:tour)).to be_valid
  end

  context 'columns' do
    it { is_expected.to have_db_column(:title).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:user_id).of_type(:integer) }
    it { is_expected.to have_db_column(:distance).of_type(:float) }
    it { is_expected.to have_db_column(:duration).of_type(:integer) }
    it { is_expected.to have_db_column(:start_lat).of_type(:decimal).with_options(precision: 10, scale: 8) }
    it { is_expected.to have_db_column(:start_lon).of_type(:decimal).with_options(precision: 10, scale: 8) }
    it { is_expected.to have_db_column(:category).of_type(:string) }
    it { is_expected.to have_db_column(:description).of_type(:text) }
  end

  context 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:sites) }
    it { is_expected.to have_many(:reviews) }
    it { is_expected.to have_many(:ratings) }
    it { is_expected.to have_many(:favorites) }
  end

  context 'validations' do
    it 'rejects invalid attachment file types' do
      expect(build(:site, image_file_name: 'image.mp3')).to_not be_valid
      expect(build(:site, image_file_name: 'audio.jpg')).to_not be_valid
    end

    it 'accepts valid  attachment types' do
      expect(build(:site, image_file_name: 'image.png')).to be_valid
      expect(build(:site, image_file_name: 'audio.m4a')).to be_valid    
    end
  end
end
