class Phone < ApplicationRecord

	belongs_to :user, optional: true
	belongs_to :contact, optional: true
end
