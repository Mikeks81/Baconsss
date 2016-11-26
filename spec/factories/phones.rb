FactoryGirl.define do
  factory :phone do
    phone_number {Faker::Number.number(10)}
    phone_type 'Mobile'
  end
end
