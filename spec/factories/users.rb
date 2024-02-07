FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test_#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }

    # emailが'test@example.com'
    trait :fixed_email do
      email { 'test@example.com' }
    end
  end
end
