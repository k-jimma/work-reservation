class ReservationsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show, :confirm]
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
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @reservation = current_user.reservations.find(params[:id])
  end

  def confirm
    @room = Room.find(params[:room_id])
    @reservation = @room.reservations.new(reservation_params)

    if @reservation.invalid?
      render :new, status: :unprocessable_entity
      return
    end
  end

  def destroy
    reservation = current_user.reservations.find(params[:id])
    reservation.destroy!
    redirect_to reservations_path, notice: "予約をキャンセルしました。"
  end

  private

  def reservation_params
    params.require(:reservation).permit(:check_in_on, :check_out_on, :guests_count)
  end

end
