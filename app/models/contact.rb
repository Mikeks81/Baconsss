class Contact < ApplicationRecord

	has_many :phones, dependent: :destroy
	accepts_nested_attributes_for :phones, allow_destroy: true

	belongs_to :user

	# def phones_attributes=(phones_attributes)
 #   		phones_attributes.each do |phone_attributes|
 #   			self.phones.build(phone_attributes)
 #   		end
 #   end	
end
