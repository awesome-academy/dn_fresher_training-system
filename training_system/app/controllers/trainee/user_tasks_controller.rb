class Trainee::UserTasksController < Trainee::BaseController
  before_action :load_user_task, :load_course_subject, only: [:update, :start_task]

  def update
    begin
      @user_task.finished!
      flash[:success] = t "controllers.user_tasks_controller.success"
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = t "controllers.user_tasks_controller.faild"
    ensure
      redirect_to trainee_course_subject_path @course_subject.id
    end
  end

  def start_task
    begin
      @user_task.in_progress!
      flash[:success] = t "controllers.user_tasks_controller.success"
      redirect_to trainee_course_subject_path @course_subject.id
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = t "controllers.user_tasks_controller.faild"
      redirect_to trainee_course_subject_path @course_subject.id
    end
  end

  private

  def load_user_task
    @user_task = UserTask.find_by id: params[:id]
    return if @user_task

    flash[:danger] = t("controllers.user_tasks_controller.error_show")
    redirect_to trainee_courses_path
  end

  def load_course_subject
    @course_subject = @user_task.user_course_subject.try(:course_subject)
  end
end
