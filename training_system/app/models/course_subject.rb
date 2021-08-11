class CourseSubject < ApplicationRecord
  belongs_to :course
  belongs_to :subject
  delegate :name, :description, :duration, to: :subject
  has_many :user_course_subjects, dependent: :destroy
  has_many :course_subjects, through: :user_course_subjects

  enum status: {init: 0, in_progress: 1, finished: 2}
  scope :course_subject_start, ->(course_id){where(course_id: course_id)}
  scope :created_asc, ->{order :created_at}
end
