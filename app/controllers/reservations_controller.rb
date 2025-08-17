class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:new, :create]
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  def index
    @reservations = current_user.reservations.includes(:room).order(created_at: :desc)
  end

  def show
  end

  def new
    @reservation = @room.reservations.new
  end

  def create
    @reservation = @room.reservations.new(reservation_params.merge(user: current_user))
    if @reservation.save
      @reservation.update(confirmed_at: Time.current)
      redirect_to reservation_path(@reservation), notice: t("flash.notice.reservation_created")
    else
      render :new
    end
  end

  def edit
    ensure_mine!
  end

  def update
    ensure_mine!
    if @reservation.update(reservation_params)
      redirect_to reservation_path(@reservation), notice: t("flash.notice.reservation_updated")
    else
      flash.now[:alert] = t("flash.alert.reservation_update_failed")
      render :edit
    end
  end

  def destroy
    ensure_mine!
    if @reservation.destroy
      redirect_to reservations_path, notice: t("flash.notice.reservation_destroyed")
    else
      redirect_to reservations_path, alert: t("flash.alert.reservation_destroy_failed")
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def ensure_mine!
    redirect_to reservations_path, alert: t("flash.alert.not_authorized") unless @reservation.user_id == current_user.id
  end

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :guests)
  end
end