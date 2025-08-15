class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :check_in, :check_out, :guests, presence: true
  validates :guests, numericality: { only_integer: true, greater_than: 0 }
  validate :check_dates
  validate :no_overlapping_reservations

  private

  def check_dates
    if check_in.present? && check_in < Date.today
      errors.add(:check_in, "は今日以降の日付を選択してください。")
    end

    if check_in.present? && check_out.present? && check_out <= check_in
      errors.add(:check_out, "はチェックインより後の日付を選択してください。")
    end
  end

  def no_overlapping_reservations
    return unless check_in.present? && check_out.present?

    overlap = Reservation.where(room_id: room_id)
                         .where.not(id: id)
                         .where("check_in < ? AND check_out > ?", check_out, check_in)

    if overlap.exists?
      errors.add(:base, "この期間はすでに予約されています。")
    end
  end
end