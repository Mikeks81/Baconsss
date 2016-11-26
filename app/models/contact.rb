class Contact < ApplicationRecord
	belongs_to :user
	has_many :phones, dependent: :destroy, inverse_of: :contact
	accepts_nested_attributes_for :phones,
	 															allow_destroy: true,
	 															reject_if: proc() { |attrs| attrs['phone_number'].blank?} 

	validates_presence_of :first_name
	validates_presence_of :phones

end
