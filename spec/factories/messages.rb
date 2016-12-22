FactoryGirl.define do
  factory :message do
    transmission "MyString"
    user nil
    body "MyText"
    to "MyString"
    from "MyString"
    location "MyString"
  end
end
