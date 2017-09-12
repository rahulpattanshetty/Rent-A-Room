class AmenitiesController < ApplicationController
before_action :authenticate_user!
  load_and_authorize_resource
before_action :set_amenity, only:[:show,:edit,:update,:destroy]
def index
	@amenity = Amenity.all
	
end
def new
	@amenity = Amenity.new
end

def create
	@amenity = Amenity.new(amenity_params)

	if @amenity.save
		redirect_to rooms_path, notice:"amenities added successfully"
	else
		render action: 'new'
	end	
end
def edit
	
end
def update
	if @amenity.update_attributes
		redirect_to rooms_path, notice:"Amenities is updated successfully"
	else
		render action:'edit'
	end
	
end
private
def amenity_params
	params[:amenity].permit(:name,:description)
	
end
def set_amenity
	@amenity = Amenity.find(params[:id])
	
end
end
