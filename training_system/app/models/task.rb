class Task < ApplicationRecord
  has_many :user_tasks, dependent: :destroy
  has_many :user_course_subjects, through: :user_tasks
  belongs_to :subject

  validates :name, :duration, presence: true
end
