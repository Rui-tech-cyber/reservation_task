class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :rooms, dependent: :destroy
  has_many :reservations, dependent: :destroy

  has_one_attached :avatar

  validates :name, presence: true
  validate :avatar_type

  def avatar_or_default
    avatar_filename.presence || "default-avatar-image.png"
  end

  def avatar_filename_or_default
    avatar_filename.present? ? avatar_filename : "default_avatar.png"
  end

  def avatar_type
    if avatar.attached? && !avatar.content_type.in?(%w(image/jpeg image/png image/gif))
      errors.add(:avatar, "はJPEG, PNG, GIF形式のみアップロードできます")
    end
  end
end