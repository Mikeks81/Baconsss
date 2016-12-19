FactoryGirl.define do
  factory :user do
    email {Faker::Internet.email}
	password 'secret'
	password_confirmation 'secret'

  after(:build) do |user|
    user.phones << FactoryGirl.build(:phone)
  end

	trait :with_contacts do
		after(:build) do |user|
			user.contacts << FactoryGirl.build(:contact, :with_phones)
		end
	end

	trait :with_phones do
		after(:build) do |user|
			user.phones << FactoryGirl.build(:phone)
		end
	end
  end
end
