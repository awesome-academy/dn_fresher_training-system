class Trainee::UserCourseSubjectsController < Trainee::BaseController
  before_action :load_user_task, only: :update

  def update
    @user_course_subject.transaction do
      byebug
      status_user_task =
        @user_course_subject.user_tasks.pluck(:status).include?("in_progress")
      unless status_user_task
        @user_course_subject.finished!
      end
      flash[:success] = t "controllers.user_course_subject_controller.success"
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = t "controllers.user_course_subject_controller.faild"
    ensure
      redirect_to trainee_courses_path
    end
  end

  private

  def load_user_task
    @user_course_subject = UserCourseSubject.find_by id: params[:id]
    return if @user_course_subject

    flash[:danger] = t("controllers.course_controller.error_show")
    redirect_to trainee_courses_path
  end
end
