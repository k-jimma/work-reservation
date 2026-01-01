# app/models/reservation.rb
class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :check_in_on, presence: true
  validates :check_out_on, presence: true
  validates :guests_count, presence: true
  validates :guests_count, numericality: { only_integer: true, greater_than_or_equal_to: 1 }, allow_blank: true
  validate  :check_in_cannot_be_in_the_past
  validate  :check_out_after_check_in

  def nights
    return 0 unless check_in_on && check_out_on
    (check_out_on - check_in_on).to_i
  end

  def total_amount
    return 0 unless room && nights.positive?
    room.price_per_night * nights * guests_count
  end

  private

  def check_in_cannot_be_in_the_past
    return if check_in_on.blank?
    errors.add(:check_in_on, "は今日以降を指定してください") if check_in_on < Date.current
  end

  def check_out_after_check_in
    return if check_in_on.blank? || check_out_on.blank?
    errors.add(:check_out_on, "はチェックイン日より後を指定してください") if check_out_on <= check_in_on
  end
end
