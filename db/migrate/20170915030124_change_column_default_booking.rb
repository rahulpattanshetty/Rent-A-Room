class ChangeColumnDefaultBooking < ActiveRecord::Migration
  def change
  	change_column :bookings, :is_confirmed, :boolean, default: false
  end
end
