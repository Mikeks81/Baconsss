class User < ApplicationRecord
  include Twilio_api
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   has_many :contacts, dependent: :destroy

   has_many :phones, dependent: :destroy
   accepts_nested_attributes_for :phones, allow_destroy: true

   has_many :profiles, dependent: :destroy

   validates :email, presence: true, uniqueness: true

   def notifications_active
    self.active ? "Notifications Active (click to turn off)" : "Activate Notifications"
  	end
end
