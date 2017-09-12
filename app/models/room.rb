class Room < ActiveRecord::Base
belongs_to :city
belongs_to :user
has_many :amenity_rooms
has_many :amenities, through: :amenity_rooms
after_create :change_default_role
before_save :take_lat_lon

def change_default_role
	if self.user.role.name == "guest"
		self.user.update_attributes(role_id:Role.second.id)
	end
	
end

def take_lat_lon
	response = HTTParty.get("http://maps.googleapis.com/maps/api/geocode/json?&address=#{self.address}")
	result = JSON.parse(response.body)
	self.latitude = result["results"][0]["geometry"]["location"]["lat"]
	self.longitude = result["results"][0]["geometry"]["location"]["lng"]

	
end
end
