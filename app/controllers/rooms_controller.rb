class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :mine]
  def index
    @rooms = Room.order(created_at: :desc)

    if params[:area].present?
      @rooms = @rooms.where("address LIKE ?", "%#{params[:area]}%")
    end

    if params[:q].present?
      @rooms = @rooms.where("title LIKE :q OR description LIKE :q", q: "%#{params[:q]}%")
    end
  end

  def show
    @room = Room.find(params[:id])
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      redirect_to mine_rooms_path, notice: "施設を登録しました。"
    else
      flash.now[:alert] = "施設の登録に失敗しました。"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @room = current_user.rooms.find(params[:id])
  end

  def update
    @room = current_user.rooms.find(params[:id])
    if @room.update(room_params)
      redirect_to mine_rooms_path, notice: "施設情報を更新しました。"
    else
      flash.now[:alert] = "施設情報の更新に失敗しました。"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @room = current_user.rooms.find(params[:id])
    @room.destroy
    redirect_to mine_rooms_path, notice: "施設を削除しました。"
  end

  def mine
    @rooms = current_user.rooms.order(created_at: :desc)
  end

  private

  def room_params
    params.require(:room).permit(:title, :description, :address, :price_per_night)
  end

end
