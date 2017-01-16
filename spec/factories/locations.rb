FactoryGirl.define do
  factory :location do
    latitude 1.5
    longitude 1.5
    is_current false
    user nil
  end
end
