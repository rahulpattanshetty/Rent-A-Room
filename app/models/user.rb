class User < ActiveRecord::Base
  
	belongs_to :role

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


   before_create :assign_default_role



   def assign_default_role
   		self.role_id = Role.last.id 
   	
   end

   def initialize(user)
      if user.role?"admin"
        can :manage, [City,Room,Amenity]
      elsif user.role?"host"
        can :read, [City,Room]
        can :create, Room
        can [:update,:destroy], Room do |room|
          room.user_id == user.id
        end
      elsif user.role?"guest"
        can :read, [City,Room]
      end
    end
end
