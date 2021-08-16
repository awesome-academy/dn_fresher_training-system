require 'rails_helper'

RSpec.describe UserCourse, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:course) }
  end

  describe "scope" do
    let!(:user_course1) {FactoryBot.create :user_course}
    let!(:user_course2) {FactoryBot.create :user_course}

    it "find user in course" do
      expect(UserCourse.user_course_in_course([user_course1.user_id, user_course2.user_id])).to eq([user_course1, user_course2])
    end
  end
end
