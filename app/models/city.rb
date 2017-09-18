class City < ActiveRecord::Base
has_many :rooms, dependent: :destroy

validates_presence_of :name
end
