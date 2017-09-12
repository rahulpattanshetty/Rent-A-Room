class User < ActiveRecord::Base
  
	belongs_to :role
  has_many :rooms

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


   before_create :assign_default_role

   def role?(role)
     self.role.name == role
   end

   def assign_default_role
   		self.role_id = Role.last.id 
   	
   end


end
