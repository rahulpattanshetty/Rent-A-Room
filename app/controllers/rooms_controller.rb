class RoomsController < ApplicationController
  before_action :authenticate_user!, except:[:index,:show]
  load_and_authorize_resource
  before_action :set_room, only:[:show,:edit,:update,:destroy]
  


  def index
  	@rooms = Room.all
  end
  def new
  	@room = Room.new
  end
  def create
  	@room = Room.new(room_params)
    @room.user_id = current_user.id
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
    #binding.pry
    if params[:room][:is_authorized]
      @room.update_attributes(is_authorized:true)
      #binding.pry
      redirect_to cities_path, notice:"Room is been authorized"
    else
      @room.user_id = current_user.id
      
    	if @room.update_attributes(room_params)
    		redirect_to rooms_path, notice:"Successfully updated"
      else
        render action:'edit'
    	end
    end
    
  end
  def destroy
  	@room.destroy
  	redirect_to rooms_path, notice:"deleted Successfully"
  end
  def unauthorize
    @rooms = Room.all
    
  end
private
	def room_params
		params[:room].permit(:name,:description,:price,:rules,:images,:address,:latitude,:longitude,:city_id,:user_id,amenity_ids:[])
	end
	def set_room
		@room = Room.find(params[:id])		
	end
end
