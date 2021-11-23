FactoryBot.define do
  factory :vaccination_list do
    date { Date.today }
    start_date { Faker::Date.between(from: 1.year.ago, to: Date.today) }
    end_date { Faker::Date.between(from: Date.today, to: 1.year.from_now) }
    association :baby, :vaccine
  end
end
