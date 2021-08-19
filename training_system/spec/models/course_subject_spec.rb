require 'rails_helper'

RSpec.describe CourseSubject, type: :model do
  describe "associations" do
    it { should belong_to(:subject) }
    it { should belong_to(:course) }
  end

  describe "validations" do
    it { should define_enum_for(:status).with([:init, :in_progress, :finished]) }
  end
end
