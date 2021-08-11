class Trainee::UserTasksController < Trainee::BaseController
  before_action :load_user_task, only: :update

  def update
    subject = @user_task.user_course_subject.course_subject
    @user_task.transaction do
      @user_task.finished!
      flash[:success] = t "controllers.user_task.create.success"
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = t "controllers.user_task.create.faild"
    ensure
      redirect_to trainee_course_subject_path subject.id
    end
  end

  private

  def load_user_task
    @user_task = UserTask.find_by id: params[:id]
    return if @user_task

    flash[:danger] = t("controllers.user_tasks_controller.error_show")
    redirect_to trainee_courses_path
  end
end
