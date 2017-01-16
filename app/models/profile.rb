class Profile < ApplicationRecord
  belongs_to :user

  has_many :profile_contact_joins, dependent: :destroy, inverse_of: :profile
  has_many :contacts, through: :profile_contact_joins

  accepts_nested_attributes_for :profile_contact_joins
  validates_presence_of :profile_contact_joins


  def self.replace_active(user)
    user.profiles.each do |profile|
      profile.update_attributes(active: false) if profile.active
    end
  end

end
