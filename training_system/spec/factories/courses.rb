FactoryBot.define do
  factory :course do
    name { Faker::Name.name }
    description { Faker::Lorem.paragraphs }
    status {1}
    start_date {"2021-08-24"}
    end_date {"2021-09-24"}
    after(:build) do |course|
      course.users << build(:user)
      course.subjects << build(:subject)
    end
  end
end
