FactoryBot.define do
  factory :user do
    sequence(:email) { |n| 'test_#{n}@example.com' }
    password { 'password' }
    password_confirmation { 'password' }

    # emailが'test@example.com'
    trait :fixed_email do
      email { 'test@example.com' }
    end

    # passwordが7文字
    trait :too_short_password do
      password { 'a' * 7 }
      password_confirmation { 'a' * 7 }
    end

    # passwordが32文字
    trait :long_password do
      password { 'a' * 32 }
      password_confirmation { 'a' * 32 }
    end

    # passwordが33文字
    trait :too_long_password do
      password { 'a' * 33 }
      password_confirmation { 'a' * 33 }
    end
  end
end
