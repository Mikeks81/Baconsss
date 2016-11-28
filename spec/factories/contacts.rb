FactoryGirl.define do
  factory :contact do
    first_name {Faker::Name.first_name}
    association :user, factory: :user

    trait :with_phones do 
	    after(:build) do |contact|
	    	contact.phones << FactoryGirl.create(:phone)
	    end
	end

	trait :without_user do
		user_id nil
	end

    factory :contact_invalid_first_name do
    	first_name ""
    end


  end
end
