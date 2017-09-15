class BookingsController < ApplicationController



def create
	@booking = Booking.new(booking_params)
	#binding.pry


	if @booking.check_start_end_date
		if @booking.errors[:base].empty?
			@booking.save
			redirect_to room_path(@booking.room_id), notice:"Wait for confirmation"
		#binding.pry
		else
			redirect_to room_path(@booking.room_id), notice:"#{@booking.errors[:base]}"
		end
	end
end
def update
	@booking = Booking.find(params[:id])
	#binding.pry
	if params[:booking][:is_confirmed]
	@booking.update_attributes(is_confirmed: true)
	#binding.pry
	redirect_to rooms_path, notice:"Confirmed"
	end
end

private
def booking_params
	params[:booking].permit(:start_date,:end_date,:user_id,:room_id)
	
end
end
