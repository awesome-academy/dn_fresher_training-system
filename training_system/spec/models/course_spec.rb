require 'rails_helper'

RSpec.describe Course, type: :model do
  describe "associations" do
    it { should have_many(:user_courses) }
    it { should have_many(:users) }
    it { should have_many(:subjects) }
  end

  describe "validations" do
    it { should define_enum_for(:status).with([:init, :in_progress, :finished]) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }

    context "check custom validation" do
      let!(:course) {FactoryBot.build(:course, name: "a", description: "b", status: 1,
                                               start_date: "2021-07-05 10:00:00", 
                                               end_date: "2021-02-05 09:00:00")}
  
      it "should not be valid if start date greater current date" do
        course.should_not be_valid
      end
    
      it "raises an error if start date greater current date" do
        course.valid?
        course.errors.full_messages.should include("Start date Please select a start date greater than the current date")
      end
  
      it "should be valid if end date is after start date" do
        course.should_not be_valid
      end
    
      it "raises an error if end date is after start date" do
        course.valid?
        course.errors.full_messages.should include("End Date cannot be before the start date")
      end
    end
  end

  describe "scope" do
    let!(:course1) {FactoryBot.create :course}
    let!(:course2) {FactoryBot.create :course}

    it "find user in course" do
      expect(Course.created_desc).to eq([course2, course1])
    end
  end
end
