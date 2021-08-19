FactoryBot.define do
  factory :task do
    name { Faker::Name.name }
    description { Faker::Lorem.paragraphs }
    duration { 1 }
  end
end
