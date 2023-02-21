FactoryBot.define do
  factory :dinosaur do
    name { Faker::Name.name }
    species { Dinosaur::DIET_BY_SPECIES.keys.sample }
    cage
  end
end
