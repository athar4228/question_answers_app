FactoryBot.define do
  google = Faker::Omniauth.google

  factory :user do
    uid        Faker::Number.number(21)
    email      Faker::Internet.unique.safe_email
    first_name Faker::Name.first_name
    last_name  Faker::Name.last_name
    provider   google[:provider]
  end
end
