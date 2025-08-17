class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :rooms, dependent: :destroy
  has_many :reservations, dependent: :destroy

  validates :name, presence: true

  def avatar_or_default
    avatar_filename.presence || "default-avatar-image.png"
  end

  def avatar_filename_or_default
    avatar_filename.present? ? avatar_filename : "default_avatar.png"
  end
end