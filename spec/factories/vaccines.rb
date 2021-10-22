FactoryBot.define do
  factory :vaccine do
    name    { Faker::Name.initials(number: 2) }
    kind_id { Faker::Number.between(from: 0, to: 2) }
  end
end
