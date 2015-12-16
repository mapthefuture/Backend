require 'rails_helper'

RSpec.describe Review, type: :model do
  it 'has a valid factory' do
    expect(build(:review)).to be_valid
  end

  context 'db' do
    it { is_expected.to have_db_column(:tagline).of_type(:string)
    it { is_expected.to have_db_column(:body).of_type(:text) }.with_options(null: false) }
    it { is_expected.to have_db_column(:user_id).of_type(:integer) }
    it { is_expected.to have_db_column(:tour_id).of_type(:integer) }
  end

  context 'assocations' do
    it {is_expected.to belong_to(:user) }
    it {is_expected.to belong_to(:tour) }
  end
end
