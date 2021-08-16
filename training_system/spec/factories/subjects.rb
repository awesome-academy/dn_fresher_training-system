FactoryBot.define do
  factory :subject do
    name { Faker::Name.name }
    description { Faker::Lorem.paragraphs }
    duration { 3 }
    after(:build) do |subject|
      subject.tasks << build(:task)
    end
  end
end
