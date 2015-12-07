class User < ActiveRecord::Base
  has_secure_password

  has_many :tours, dependent: :destroy
  has_many :ratings
  has_many :reviews
  has_many :favorites, dependent: :destroy

  has_attached_file :avatar
  validates_attachment_file_name :avatar, matches: [/png\Z/, /jpg\Z/, /jpeg\Z/]

  before_validation :ensure_access_token!

  validates_presence_of :first_name, :last_name
  validates_uniqueness_of :email
  validates_format_of :email, with: /.+@.+\..+/
  validates :access_token, presence: true, uniqueness: true

  attr_accessor :image_data,:image
  before_save :decode_image_data

  def decode_image_data
    if self.image_data.present?
      data = StringIO.new(Base64.decode64(self.image_data))
      data.class.class_eval {attr_accessor :original_filename, :content_type}
      data.original_filename = self.id.to_s + ".png"
      data.content_type = "image/png"
      self.avatar = data
    end
  end

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
