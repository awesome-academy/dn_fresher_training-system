require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "associations" do
    it { should have_many(:user_tasks) }
    it { should have_many(:user_course_subjects) }
    it { should belong_to(:subject) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:duration) }
  end
end
