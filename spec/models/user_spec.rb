require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  it 'accepts png as a valid attachment type' do
    expect(build(:user, avatar_file_name: 'audio.mp3')).to_not be_valid
  end
end
