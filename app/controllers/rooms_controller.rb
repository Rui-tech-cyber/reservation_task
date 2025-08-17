class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:search, :show]

  def index
    @rooms = current_user.rooms.order(created_at: :desc)
  end

  def show
    @room = Room.find(params[:id])
    @reservations = @room.reservations.includes(:user).order(check_in: :asc)
  end

  def new
    @room = current_user.rooms.new
  end

  def create
    @room = current_user.rooms.new(room_params)
    if @room.save
      redirect_to @room, notice: t("flash.notice.room_created")
    else
      render :new
    end
  end

  def search
    @area = params[:area]
    @keyword = params[:keyword]

    scope = Room.all
    if @area.present?
      cities = %w(東京 大阪 京都 札幌)
      if cities.include?(@area)
        scope = scope.where("address LIKE ?", "%#{@area}%")
      end
    end
    if @keyword.present?
      scope = scope.where("name LIKE :q OR description LIKE :q", q: "%#{@keyword}%")
    end
    @rooms = scope.order(created_at: :desc)
  end

  private

  def room_params
    params.require(:room).permit(:name, :description, :price, :address, :image, :image_filename)
  end
end