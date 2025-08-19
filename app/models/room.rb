class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy

  has_one_attached :image

  validates :name, :description, :price, :address, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 1 }

  def image_or_default
    if image.attached?
      image
    else
      "default-institution-image.png"
    end
  end


  def image_filename_or_default
    image_filename.presence || "default-institution-image.png"
  end
end