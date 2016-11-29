class Contact < ApplicationRecord
	belongs_to :user
	has_many :phones, dependent: :destroy
	accepts_nested_attributes_for :phones, allow_destroy: true

	has_many :profile_contact_joins
	has_many :profiles, through: :profile_contact_joins

	validates_presence_of :first_name
	validates_presence_of :phones

end
