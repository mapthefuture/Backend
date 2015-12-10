require 'rails_helper'
require 'spec_helper'

RSpec.describe Rating, type: :model do
  it 'should have a valid factory' do
    expect(build(:rating)).to be_valid
  end

  context 'db' do
    it { is_expected.to have_db_column(:score).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:rateable_id).of_type(:integer) }
    it { is_expected.to have_db_column(:rateable_type).of_type(:string) }
    it { is_expected.to have_db_column(:user_id).of_type(:integer) }
  end

  context 'associations' do
    it { is_expected.to belong_to(:rateable) }
    it { is_expected.to belong_to(:user) }
  end

  context 'validations' do
    it 'only accepts values between 1 and 5 for its score' do
      expect(build(:rating, score: rand(1..5))).to be_valid
    end

    it 'rejects values greater than 5' do
      expect(build(:rating, score: rand(6..100))).to_not be_valid
    end
  end
end

describe '#tour_name' do
  it 'generates the name of the tour the rating belongs to' do
    tour = FactoryGirl.create(:tour)
    rating = FactoryGirl.create(:rating, rateable: tour)
    expect(rating.tour_name).to eq(tour.title)
  end
end