class Notification < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification.room_authorization.subject
  #
  def room_authorization(room)
    @room = room

    mail to: "#{@room.user.email}", subject:"Room authorized"
  end
  def waiting_confirmation(booking)
  	@booking = booking

  	mail to:"#{@booking.user.email}", subject:"Waiting for confirmation"
  	
  end
  def confirmed_booking(booking)
  	@booking = booking

  	mail to:"#{@booking.user.email}", subject:"Waiting for confirmation"
  end
  def host(booking)
  	@booking = booking

  	mail to:"#{@booking.room.user.email}", subject:"Waiting for confirmation"
  end
end
