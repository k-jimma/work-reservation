class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy
  has_one_attached :image

  validates :title, :description, :address, presence: true
  validates :price_per_night, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  def display_image
    if image.attached?
      image
    else
      OpenStruct.new(url: ApplicationHelper::ROOM_FALLBACK_URL)
    end
  end
end
