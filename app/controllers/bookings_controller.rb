class BookingsController < ApplicationController
load_and_authorize_resource
before_action :set_params, only: [:show,:edit,:destroy]

def create
	@booking = Booking.new(booking_params)
	@booking.user_id = current_user.id
	binding.pry
	@booking.save
	if @booking.errors[:base].empty?
		Notification.waiting_confirmation(@booking).deliver!
		Notification.host(@booking).deliver!
		redirect_to room_path(@booking.room_id), notice:"Wait for confirmation"
		#binding.pry
	else
		redirect_to room_path(@booking.room_id), notice:"#{@booking.errors[:base]}"
	end
end

def update
	@booking = Booking.find(params[:id])
	#binding.pry
	if params[:booking][:is_confirmed]
	@booking.update_attributes(is_confirmed: true)
	Notification.confirmed_booking(@booking).deliver!
	#binding.pry
	redirect_to rooms_path, notice:"Confirmed"
	end
end
def destroy
	@booking.destroy
	redirect_to rooms_path, notice:"Booking cancelled successfully"
	
end

private
def booking_params
	params[:booking].permit(:start_date,:end_date,:user_id,:room_id,:price)
end
def set_params
	@booking = Booking.find(params[:id])
	
end
end
