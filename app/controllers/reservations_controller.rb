class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:new, :create]
  before_action :set_reservation, only: [:edit, :update, :destroy]

  def index
    @reservations = current_user.reservations.includes(:room).order(check_in: :asc)
  end

  def new
    @reservation = @room.reservations.new
  end

  def create
    @reservation = @room.reservations.new(reservation_params)
    @reservation.user = current_user

    if @reservation.save
      redirect_to room_path(@room), notice: "予約が完了しました。"
    else
      render :new
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
    @room = @reservation.room
  end

  def update
    @reservation = Reservation.find(params[:id])
    @room = @reservation.room
    if @reservation.update(reservation_params)
      redirect_to reservations_path, notice: "予約内容を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to reservations_path, notice: "予約をキャンセルしました。"
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_reservation
    @reservation = current_user.reservations.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :guests)
  end
end