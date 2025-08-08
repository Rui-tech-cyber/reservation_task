class User < ApplicationRecord
  has_many :rooms
  has_many :reservations

  validates :name, presence: true, length: { maximum: 30 }
  validates :profile, length: { maximum: 300 }, allow_blank: true
end
