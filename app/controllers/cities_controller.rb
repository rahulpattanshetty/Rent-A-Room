class CitiesController < ApplicationController


  load_and_authorize_resource

def index
	@cities =City.all
	
end

def new
	@city = City.new	
end

def create
	@city = City.new(city_params)
	@name = City.find_by(name:@city.name)
	if @name.nil? && @city.save
		
		redirect_to cities_path, notice: "Successfully added"
	else
		if !(@name.nil?)
			redirect_to new_city_path, notice:"City already exists"
		else
			render action:'new'
		end
	end
	
end
def show
	@city = City.find(params[:id])
	
	
end
def edit
	@city = City.find(params[:id])
	
end
def update
	@city = City.find(params[:id])
	if @city.update_attributes(city_params)
		redirect_to cities_path, notice: "updated successfully"
	else
		render action:'edit'
	end	
end
def destroy
	@city = City.find(params[:id])
	if @city.destroy
		redirect_to cities_path, notice:"deleted successfully"
	end

	
end

private
def city_params
	params[:city].permit(:name)
	
end
end
