FactoryGirl.define do
  factory :website do
    address {Faker::Internet.url}
    rank
    user
  end
  sequence (:rank) { |n| n }
end
