FactoryBot.define do
  factory :question do
    title Faker::Lorem.sentence(5)
    body Faker::Lorem.sentence(20)
    author { create(:user, email: Faker::Internet.unique.safe_email) }
  end
end
