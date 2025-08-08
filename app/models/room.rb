class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations

  validates :name, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 1000 }, allow_blank: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :address, presence: true, length: { maximum: 100 }
end
