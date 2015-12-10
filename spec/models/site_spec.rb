require 'rails_helper'

RSpec.describe Site, type: :model do
  it 'has a valid factory' do
    expect(build(:site)).to be_valid
  end

  context 'db' do 
    it { is_expected.to have_db_column(:title).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:tour_id).of_type(:integer) }
    it { is_expected.to have_db_column(:description).of_type(:text) }
    it { is_expected.to have_db_column(:image_file_name).of_type(:string) }
    it { is_expected.to have_db_column(:audio_file_name).of_type(:string) }
    it { is_expected.to have_db_column(:latitude).of_type(:decimal).with_options(precision: 10, scale: 8) }
    it { is_expected.to have_db_column(:longitude).of_type(:decimal).with_options(precision: 10, scale: 8) }
    it { is_expected.to have_db_column(:street).of_type(:string) }
    it { is_expected.to have_db_column(:city).of_type(:string) }
    it { is_expected.to have_db_column(:state).of_type(:string) }
    it { is_expected.to have_db_column(:zip).of_type(:integer) }
    it { is_expected.to have_db_column(:street).of_type(:string) }
  end

  context 'associations' do
    it { is_expected.to belong_to(:tour) }
    it { is_expected.to have_many(:ratings) }
  end
end
