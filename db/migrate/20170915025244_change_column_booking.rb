class ChangeColumnBooking < ActiveRecord::Migration
  def change
  	change_column_default :bookings, :is_confirmed, default: false
  end
end
