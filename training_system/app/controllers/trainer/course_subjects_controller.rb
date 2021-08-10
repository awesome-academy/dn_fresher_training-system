class Trainer::CourseSubjectsController < Trainer::BaseController
  before_action :load_subject, only: :update

  def update
    status = @course_subject.user_course_subjects.pluck(:status).include?("in_progress")

    if status
      flash[:danger] = t("controllers.course_subjects_controller.fail")
      redirect_to trainer_course_path @course.id
    else
      @course_subject.finished!
      flash[:success] = t("controllers.course_subjects_controller.success")
      redirect_to trainer_course_path @@course.id
    end
  end

  private

  def load_subject
    @course = Course.find_by id: params[:course_id]
    @course_subject = @course.course_subjects.find_by subject_id: params[:subject_id]
    return if @course_subject

    flash[:danger] = t("controllers.course_subjects_controller.error_show")
    redirect_to trainee_courses_path
  end
end
