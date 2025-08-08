class User < ApplicationRecord
  has_many :rooms
  has_many :reservations

  #deviseの設定も含める
end
