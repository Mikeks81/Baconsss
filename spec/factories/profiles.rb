FactoryGirl.define do
  factory :profile do
    text_user_interval {Faker::Number.between(1,24)}
    response_time {Faker::Number.between(1,24)}
    text_contact_time {Faker::Number.between(1,24)}
    active false
    user

    trait :active_true do
    	active true
    end

    trait :with_contacts_join do
    	after(:build) do |profile|
    		profile.profile_contact_joins << FactoryGirl.create(:profile_contact_join,
    				    profile: profile,
    				    contact: build(:contact, :with_phones))
    	end
    end
  end
end
