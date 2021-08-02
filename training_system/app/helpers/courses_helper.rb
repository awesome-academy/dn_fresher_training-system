module CoursesHelper
  def subject_select
    Subject.select(:id, :name)
  end
end
