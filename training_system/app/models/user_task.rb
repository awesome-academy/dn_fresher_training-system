class UserTask < ApplicationRecord
  belongs_to :user_course_subject
  belongs_to :task
  enum status: {init: 0, in_progress: 1, finished: 2}
  delegate :name, :duration, :description, to: :task
end
