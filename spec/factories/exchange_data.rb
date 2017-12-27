FactoryGirl.define do
  factory :exchange_datum do
    date { Faker::Date.between(20.years.ago, Date.current) }
    coef { Faker::Number.decimal(2) }
  end
end
