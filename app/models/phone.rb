class Phone < ApplicationRecord

	belongs_to :user, optional: true
	belongs_to :contact, optional: true

	validates_presence_of :phone_number
end
