class CourseSubject < ApplicationRecord
  belongs_to :course
  belongs_to :subject
  has_many :user_course_subjects, dependent: :destroy
  has_many :user_course, through: :user_course_subjects
  delegate :name, :duration, :description, to: :subject

  enum status: {awaiting: 0, in_progress: 1, finished: 2}
  scope :course_subject_start, ->(course_id){where(course_id: course_id)}
  scope :created_asc, ->{order :created_at}
end
