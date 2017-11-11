FactoryBot.define do
  factory :membership do
    nickname { Faker::Name.first_name }
    role :member
    user
    fraternity
  end
end
