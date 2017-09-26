class Review < ActiveRecord::Base
belongs_to :room



def self.check_user_stay_with_room(room_id,user_id)
	bookings = Booking.where('room_id = ? AND user_id = ?',room_id,user_id)
	binding.pry
	if bookings.empty?
		return false
	else
		bookings = bookings.where('end_date < ?', Date.today)
		if bookings.empty?
			return false
		else
			return true
		end
	end
end

end
