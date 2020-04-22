class User < ApplicationRecord
  # imageuploaderマウント
  mount_uploader :image, ImageUploader

  # アソシエーション
  has_many :events, dependent: :destroy
  has_many :event_participants, dependent: :destroy
  has_many :participate_events, through: :event_participants, source: :event

  # バリデーション
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
  before_validation { email.downcase! }

  # deviseメソッド
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,:omniauthable, omniauth_providers: %i(google)

  # oauthメソッド
  def self.create_unique_string
    SecureRandom.uuid
  end

  def self.find_for_google(auth)
    user = User.find_by(email: auth.info.email)
    unless user
      user = User.new(name: auth.info.name,
                      email: auth.info.email,
                      provider: auth.provider,
                      uid:      auth.uid,
                      password: Devise.friendly_token[0, 20],
                                   )
    end
    user.save
    user
  end

end
