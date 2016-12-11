class User < ApplicationRecord
  include Twilio_api
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   has_many :contacts, dependent: :destroy

   has_one :phone, dependent: :destroy
   accepts_nested_attributes_for :phone, allow_destroy: true

   has_many :profiles, dependent: :destroy

   validates :email, presence: true, uniqueness: true
end
