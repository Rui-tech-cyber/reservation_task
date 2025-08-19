class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  before_create :set_confirmed_at

  validates :check_in, :check_out, :guests, presence: true
  validates :guests, numericality: { only_integer: true, greater_than: 0 }
  validate :check_dates
  validate :no_overlapping_reservations

  def stay_days
    return 0 unless check_in.present? && check_out.present?
    (check_out - check_in).to_i
  end

  def total_price
    return 0 unless room.present?
    stay_days * guests * room.price
  end

  private

  def check_dates
    if check_in.present? && check_in < Date.today
      errors.add(:check_in, I18n.t("errors.custom.check_in_today_or_later"))
    end
    if check_in.present? && check_out.present? && check_out <= check_in
      errors.add(:check_out, I18n.t("errors.custom.check_out_after_check_in"))
    end
  end

  def no_overlapping_reservations
    return unless check_in.present? && check_out.present?
    overlap = Reservation.where(room_id: room_id)
                         .where.not(id: id)
                         .where("check_in < ? AND check_out > ?", check_out, check_in)
    errors.add(:base, I18n.t("errors.custom.already_booked")) if overlap.exists?
  end

  def set_confirmed_at
    self.confirmed_at ||= Time.current
  end
end