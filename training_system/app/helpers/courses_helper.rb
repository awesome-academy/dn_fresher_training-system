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

  def status_subject subject, course
    subject.course_subjects.find_by(course_id: course.id).status
  end

  def status_subject_trainee(user_course_subjects, course_subject)
    status_subject = user_course_subjects
                     .find_by(course_subject_id: course_subject.id)
    if status_subject.present?
      status_subject = user_course_subjects
                       .find_by(course_subject_id: course_subject.id).status
    else
      content_tag(:span, t("helper.course.awaiting"))
    end
  end
end
