class Booking < ActiveRecord::Base
belongs_to :room
belongs_to :user

validates_presence_of :start_date,:end_date
validate :check_start_end_date, on: :create

before_save :check_discount

def check_start_end_date

	if self.start_date <= self.end_date
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
	else
		self.errors.add(:base,"End date can't be less than start date")
	end
end

def check_discount
	total = 0
	count = 0
	current_booking = (self.start_date..self.end_date).to_a
	len = current_booking.length
	self.room.special_prices.each do |special_price|
		if special_price.room_id == self.room_id
			dates = ((special_price.start_date..special_price.end_date)).to_a
			dates.each do |date|
				if current_booking.include?date
					total += special_price.price
					count +=1 
				end
			end
		end
	end
		len -= count
		total = total + self.room.price * len
		self.price = total 
end
end
