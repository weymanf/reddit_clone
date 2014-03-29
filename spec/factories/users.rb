# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name }
    password { Faker::Lorem.words(6) }
  end
end
