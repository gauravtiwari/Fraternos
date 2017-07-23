FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    name { Faker::RickAndMorty.character }
    confirmed_at { Time.zone.now }
  end
end
