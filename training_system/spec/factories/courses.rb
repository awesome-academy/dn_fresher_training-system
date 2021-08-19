FactoryBot.define do
  factory :course do
    name { Faker::Name.name }
    description { Faker::Lorem.paragraphs }
    status { 1 }
    start_date { Faker::Date.between(from: "2021-09-19", to: "2021-09-20") }
    end_date { Faker::Date.between(from: "2021-11-19", to: "2021-12-20") }
    after(:build) do |course|
      course.users << build(:user)
      course.subjects << build(:subject)
    end
  end
end
