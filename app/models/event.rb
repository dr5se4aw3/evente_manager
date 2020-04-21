class Event < ApplicationRecord
  # imageuploaderマウント
  mount_uploader :event_image, ImageUploader
  # バリデーション
  validates :title, presence: true
  validates :started_at, presence: true
  validates :closed_at, presence: true
  validates :venue_name, presence: true
  validates :venue_address, presence: true
  validates :venue_url, presence: true
  # アソシエーション
  belongs_to :user
  has_many :event_participants , dependent: :destroy
end
