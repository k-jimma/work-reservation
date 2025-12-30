class MypagesController < ApplicationController
  before_action :authenticate_user!

  def show
    @rooms_count = current_user.rooms.count
    @reservations_count = current_user.reservations.count

    @recent_rooms = current_user.rooms.order(created_at: :desc).limit(6)
    @recent_reservations = current_user.reservations.includes(:room).order(created_at: :desc).limit(6)

    @has_more_rooms = current_user.rooms.count > 6
    @has_more_reservations = current_user.reservations.count > 6
  end
end
