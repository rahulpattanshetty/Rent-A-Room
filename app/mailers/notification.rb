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
end
