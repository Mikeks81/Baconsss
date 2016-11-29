class ProfileContactJoin < ApplicationRecord
  belongs_to :profile
  belongs_to :contact
end
