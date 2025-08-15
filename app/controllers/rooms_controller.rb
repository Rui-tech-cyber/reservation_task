class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = Room.all

    if params[:area].present?
      @rooms = @rooms.where("address LIKE ?", "%#{params[:area]}%")
    end

    if params[:keyword].present?
      keyword = "%#{params[:keyword]}%"
      @rooms = @rooms.where("name LIKE ? OR address LIKE ?", keyword, keyword)
    end
  end

  def show
    @room = Room.find(params[:id])
    @reservations = @room.reservations.order(check_in: :asc)
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params.merge(user: current_user))
    if @room.save
      redirect_to @room, notice: "施設を作成しました。"
    else
      render :new
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, :description, :price, :address)
  end
end