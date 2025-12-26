class ReservationsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :confirm]
  def index
    @reservations = current_user.reservations.includes(:room).order(created_at: :desc)
  end

  def new
    @room = Room.find(params[:room_id])
    @reservation = Reservation.new
  end

  def create
    @room = Room.find(params[:room_id])
    @reservation = current_user.reservations.build(reservation_params)
    @reservation.room = @room
    @reservation.confirmed_at = Time.current

    if @reservation.save
      redirect_to reservations_path, notice: "予約を確定しました。"
    else
      flash.now[:alert] = "予約の確定に失敗しました。"
      render :confirm, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def confirm
    @room = Room.find(params[:room_id])
    @reservation = Reservation.new(reservation_params)
    @reservation.user = current_user
    @reservation.room = @room
  end

  private

  def reservation_params
    params.require(:reservation).permit(:check_in_on, :check_out_on, :guests_count)
  end

end
