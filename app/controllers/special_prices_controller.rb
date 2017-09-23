class SpecialPricesController < ApplicationController
load_and_authorize_resource :room
load_and_authorize_resource :special_price, through: :room

def index
	@special_prices = SpecialPrice.all
	
end

def new
	@special_price = SpecialPrice.new
	
end
def create
	@special_price = SpecialPrice.new(special_price_params)
	@special_price.room_id = params[:room_id]
	@special_prices = SpecialPrice.all
	if @special_price.save

		redirect_to special_price_path
	end

end
private
def special_price_params
	params[:special_price].permit(:start_date,:end_date,:price,:room_id)
	
end
end
