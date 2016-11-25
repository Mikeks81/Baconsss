class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   has_many :contacts, dependent: :destroy

   has_many :phones, dependent: :destroy
   accepts_nested_attributes_for :phones, allow_destroy: true

   validates_presence_of :email
end
