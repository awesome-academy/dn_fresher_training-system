class AddStartDateToUserCourseSubject < ActiveRecord::Migration[6.1]
  def change
    add_column :user_course_subjects, :start_date, :date
    add_column :user_course_subjects, :end_date, :date

  end
end
