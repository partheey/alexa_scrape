FactoryGirl.define do
  factory :user do
    email
    password 'password'
  end
  sequence (:email) { |n| "email_#{n}@test.com" }
end
