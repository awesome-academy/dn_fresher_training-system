require 'rails_helper'

RSpec.describe Subject, type: :model do
  describe "associations" do
    it { should have_many(:course_subjects) }
    # it { should have_many(:courses) }
    it { should have_many(:tasks) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:duration) }

    context "check custom validation" do
      let!(:subject) { Subject.new(name: "a", description: "b", duration: 1) }

      it "should not be valid if at least one subject task" do
        subject.should_not be_valid
      end
    
      it "raises an error if at least one subject task" do
        subject.valid?
        subject.errors.full_messages.should include("Must have at task one Subject")
      end
    end
  end
end
