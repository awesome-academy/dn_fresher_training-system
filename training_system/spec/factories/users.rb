FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password {"123123"}
    password_confirmation {"123123"}
    roles { 1 }
    address { Faker::Address.full_address }
  end
end
