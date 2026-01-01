class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy, :mine ]

  def index
    @rooms = Room.order(created_at: :desc)

    allowed_areas = %w[東京 大阪 京都 札幌]

    area = params[:area].to_s.strip
    # q    = params[:q].to_s.strip
    raw_q = params[:q].to_s.strip

    normalized_q = raw_q.gsub(/　/, " ") # 全角スペースを半角に
    tokens = normalized_q.split(/\s+/).reject(&:blank?)

    if area.blank? && tokens.any?
      hit = tokens.find { |t| allowed_areas.include?(t) }
      if hit
        area = hit
        tokens = tokens - [ hit ] # 残りがフリーワード
      end
    end

    if area.present? && allowed_areas.include?(area)
      like_area = "%#{ActiveRecord::Base.sanitize_sql_like(area)}%"
      @rooms = @rooms.where("address LIKE ?", like_area)
    end

    # tokens が残ってたらそれぞれを title/description に OR で当てる
    if tokens.any?
      likes = tokens.map { |t| "%#{ActiveRecord::Base.sanitize_sql_like(t)}%" }

      conditions = likes.map do
        "(title LIKE ? OR description LIKE ?)"
      end.join(" AND ")

      binds = likes.flat_map { |lk| [ lk, lk ] }

      @rooms = @rooms.where([ conditions, *binds ])
    end

    @rooms_count = @rooms.count
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
    params.require(:room).permit(
      :title,
      :description,
      :address,
      :price_per_night,
      :image
    )
  end
end
