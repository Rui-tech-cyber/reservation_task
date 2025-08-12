class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :rooms
  has_many :reservations

  validates :name, presence: true, length: { maximum: 30 }
  validates :phone_number, presence: true, format: { with: /\A\d{10,11}\z/, message: 'はハイフンなしの10桁または11桁で入力してください' }
  validates :profile, length: { maximum: 300 }, allow_blank: true
end