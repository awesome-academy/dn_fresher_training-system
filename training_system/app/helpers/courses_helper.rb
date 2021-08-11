module CoursesHelper
  def status_select
    Course.statuses.keys
  end

  def subject_select
    Subject.select(:id, :name)
  end

  def user_select
    User.select(:id, :name)
  end

  def show_status_user_subject course_subject
    user_course =
      course_subject.user_course.find_by(user_id: current_user.id)
    course_subject.user_course_subjects.find_by(
      course_subject_id: course_subject.id,
      user_course_id: user_course.id
    ).status
  end

  def check_status_user_task user_course_subject
    user_course_subject.user_tasks.pluck(:status).include?("in_progress")
  end
end
