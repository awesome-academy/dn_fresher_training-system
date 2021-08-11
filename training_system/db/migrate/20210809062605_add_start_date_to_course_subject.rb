class AddStartDateToCourseSubject < ActiveRecord::Migration[6.1]
  def change
    add_column :course_subjects, :start_date, :date
    add_column :course_subjects, :end_date, :date
  end
end
