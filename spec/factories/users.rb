FactoryBot.define do
    factory :user do
      email { Faker::Internet.email }
      password { "password123" }
      association :profile
    end
  end