class Booking < ActiveRecord::Base
belongs_to :room
belongs_to :user

validates_presence_of :start_date,:end_date


def check_start_end_date
	current_booking = (self.start_date..self.end_date).to_a
	bookings = Booking.where('room_id = ?',self.room_id)
	
	bookings.each do |booking|
		future_bookings=(booking.start_date..booking.end_date).to_a
		current_booking.each do |date|
			if future_bookings.include?date 
				self.errors.add(:base,"Already booked")			
		  	end	
		end
	end
end
end
