class Trainee::CourseSubjectsController < Trainee::BaseController
  before_action :load_subject,
                :load_user_course_subject,
                :load_task_subject, only: [:show, :update]

  def show; end

  def update; end

  private

  def load_subject
    @course_subject = CourseSubject.find_by id: params[:id]
    return if @course_subject

    flash[:danger] = t("controllers.course_subjects_controller.error_show")
    redirect_to trainee_courses_path
  end

  def load_user_course_subject
    @user_course = @course_subject.user_course.find_by(user_id: current_user.id)
    @user_course_subject =
      @course_subject.user_course_subjects.find_by(
        user_course_id: @user_course.id,
        course_subject_id: @course_subject.id
      )
  end

  def load_task_subject
    @task_subjects = @user_course_subject.user_tasks
  end
end
