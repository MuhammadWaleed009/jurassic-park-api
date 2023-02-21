FactoryBot.define do
  factory :cage do
    max_capacity { Faker::Number.between(from: 1, to: 10) }
    power_status { 'active' }

    trait :power_down do
      power_status { 'down' }
    end
  end
end
