class RoomsController < ApplicationController
  before_action :set_room, only:[:show,:edit,:update,:destroy]

  def index
  	@rooms = Room.all
  end
  def new
  	@room = Room.new
  end
  def create
  	@room = Room.new(room_params)
  	if @room.save
  		redirect_to rooms_path, notice:"Successfully added"
  	else
  		render action:'new'
  	end
  end
  def show
  	
  end
  def edit
  	
  end
  def update
  	@room = Room.new(room_params)
  	if @room.update_attributes
  		redirect_to rooms_path, notice:"Successfully updated"
  	end
  end
  def destroy
  	@room.destroy
  	redirect_to rooms_path, notice:"deleted Successfully"
  end

private
	def room_params
		params[:room].permit(:name,:description,:price,:rules,:images,:address,:latitude,:longitude,:city_id,:user_id)
	end
	def set_room
		@room = Room.find(params[:id])		
	end
end
