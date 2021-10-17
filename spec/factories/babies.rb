FactoryBot.define do
  factory :baby do
    nickname { Faker::Name.initials(number: 2) }
    birthday { Faker::Date.birthday }
    association :user
  end
end
