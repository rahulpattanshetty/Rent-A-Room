class ReviewsController < ApplicationController

def new
@review = Review.new
	
end
def create
	@review = Review.new(reviews_params)
	@review.user_id = current_user.id
	if @review.save
		redirect_to room_path(@review.room_id), notice:"review added successfully"
	end	
end



private
def reviews_params
	params[:review].permit(:review,:food_rating,:safety_rating,:facility_rating,:locality_rating,:cleanliness_rating,:room_id)
	
end
end
