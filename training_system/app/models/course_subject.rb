class CourseSubject < ApplicationRecord
  belongs_to :course
  belongs_to :subject
  enum status: {init: 0, in_progress: 1, finished: 2}
end
