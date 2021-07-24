class UserCourseSubject < ApplicationRecord
  belongs_to :user_course
  belongs_to :course_subject
  has_many :user_tasks, dependent: :destroy
  has_many :tasks, through: :user_tasks
end
