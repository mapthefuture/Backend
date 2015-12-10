require 'rails_helper'
require 'spec_helper'

RSpec.describe Favorite, type: :model do
  it 'has a valid factory' do
    expect(build(:favorite)).to be_valid
  end

  context 'db' do
    it { is_expected.to have_db_column(:user_id).of_type(:integer) }
    it { is_expected.to have_db_column(:favoritable_id).of_type(:integer) }
    it { is_expected.to have_db_column(:favoritable_type).of_type(:string) }
  end

  context 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:favoritable) }
  end
end
