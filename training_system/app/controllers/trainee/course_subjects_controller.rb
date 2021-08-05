class Trainee::CourseSubjectsController < Trainee::BaseController
  before_action :load_subject, only: :update

  def update
    ActiveRecord::Base.transaction do
      course_subject_start =
        CourseSubject.course_subject_start(@course_subject.course_id).init.created_asc

      @course_subject.finished!
      unless course_subject_start.blank?
        course_subject_start.first.in_progress!
      else
        @course_subject.course.finished!
      end
      flash[:success] = t("controllers.course_subjects_controller.success")
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = t("controllers.course_subjects_controller.fail")
    ensure
      redirect_to trainee_course_path @course_subject.course_id
    end
  end

  def load_subject
    @course_subject = CourseSubject.find_by id: params[:id]
    return if @course_subject

    flash[:danger] = t("controllers.course_subjects_controller.error_show")
    redirect_to trainee_courses_path
  end
end
