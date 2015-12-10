class User < ActiveRecord::Base
  has_secure_password

  has_many :tours, dependent: :destroy
  has_many :ratings
  has_many :reviews
  has_many :favorites, dependent: :destroy

  has_attached_file :avatar
  validates_attachment_file_name :avatar, matches: [/png\Z/, /jpg\Z/, /jpeg\Z/]

  before_validation :ensure_access_token!

  validates_presence_of :first_name, :email, :access_token
  validates_uniqueness_of :email, :access_token
  validates_format_of :email, with: /.+@.+\..+/

  def ensure_access_token!
    if self.access_token.blank?
      self.access_token = User.generate_token
    end
  end

  def self.generate_token
    token = SecureRandom.hex
    while User.exists?(access_token: token)
      token = SecureRandom.hex
    end
    token
  end

  def favorite_tours
    favorites = Favorite.where(favoritable_type: "Tour", user_id: self.id)
  end
end
