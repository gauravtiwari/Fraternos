FactoryBot.define do
  factory :fraternity do
    name { Faker::RickAndMorty.location }

    transient do
      owner { create(:user) }
    end

    after(:create) do |fraternity, evaluator|
      create(:membership, fraternity: fraternity, user: evaluator.owner, role: :owner)
    end

    trait :with_members do
      transient do
        members_count 5
      end

      after(:create) do |fraternity, evaluator|
        evaluator.members_count.times do
          create(:membership, fraternity: fraternity, user: create(:user), role: :member)
        end
      end
    end
  end
end
