FactoryGirl.define do
  factory :profile do
    # user nil
    # contacts nil
    text_user_interval {Faker::Number.between(1,24)}
    response_time {Faker::Number.between(1,24)}
    text_contact_time {Faker::Number.between(1,24)}
    active false

    trait :active_true do
    	active true
    end
  end
end
