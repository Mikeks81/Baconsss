class User < ApplicationRecord
  include Twilio_api
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   has_many :contacts, dependent: :destroy

   has_many :phones, dependent: :destroy, inverse_of: :user
   accepts_nested_attributes_for :phones, allow_destroy: true

   has_many :profiles, dependent: :destroy

   validates :email, presence: true, uniqueness: true
   validate :has_phone_and_uniqe

   def notifications_active
    self.active ? "Notifications Active (click to turn off)" : "Activate Notifications"
   end

   private

   def has_phone_and_uniqe
    #need to filter if there is a 1 in front of an area code. right now it thinking a nubmer with a 1 infront of it is a different number .. ex.. 19174704721 != 9174704721.. but it should be recognized as such.
    user_phone = self.phones.first.phone_number
    exisitng_record = Phone.where(phone_number: user_phone, contact_id: nil)

    if user_phone.nil?
      errors.add :base,"User must have a phone number"
    elsif exisitng_record.exists?
      errors.add :base, "Phone number already exists"
    end
   end
end
