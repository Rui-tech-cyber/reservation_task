class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = Room.all
  end

  def show
    @room = Room.find(params[:id])
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