FactoryBot.define do
  factory :user do
    email           { Faker::Internet.free_email }
    password        { 'a1' + Faker::Internet.password(min_length: 4) }
    relationship_id { Faker::Number.between(from: 0, to: 2) }
  end
end