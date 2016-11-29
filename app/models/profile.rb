class Profile < ApplicationRecord
  belongs_to :user

  has_many :profile_contact_joins, dependent: :destroy
  has_many :contacts, through: :profile_contact_joins
end
