FactoryGirl.define do
  factory :phone do
    phone_number {Faker::Number.number(10)}
    phone_type 'Mobile'

    trait :without_phone_number do 
    	phone_number ""
    end

    trait :with_user do
    	after(:build) do |phone|
    		phone.user = FactoryGirl.build(:user)
    	end
    end

    trait :with_contact do
    	after(:build) do |phone|
    		phone.contact = FactoryGirl.build(:contact)
    	end
    end
  end
end
