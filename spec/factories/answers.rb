FactoryBot.define do
  factory :answer do
    body Faker::Lorem.sentence(20)
    question { create(:question) }
    author { create(:user, email: Faker::Internet.unique.safe_email) }
  end
end
