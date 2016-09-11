FactoryGirl.define do
  factory :rank_log do
    old_value {Faker::Number.number(3)}
    new_value {Faker::Number.number(3)}
    website
  end
end
