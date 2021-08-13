class Trainee::UserCourseSubjectsController < Trainee::BaseController
  before_action :load_user_course_subject,
                :check_status_user_task,
                only: [:update, :start_subject]

  def update
    begin
      @user_course_subject.finished!
      @user_course_subject.update!(end_date: Time.zone.now.to_date)
      flash[:success] = t "controllers.user_course_subject_controller.success"
      redirect_to trainee_course_subject_path @user_course_subject.course_subject.id
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = t "controllers.user_course_subject_controller.faild"
      redirect_to trainee_course_subject_path @user_course_subject.course_subject.id
    end
  end

  def start_subject
    ActiveRecord::Base.transaction do
      @user_course_subject.in_progress!
      @user_course_subject.update!(start_date: Time.zone.now.to_date)
      @user_course_subject.course_subject.try(:subject).try(:tasks).each do |user_task|
        @user_course_subject.user_tasks.build(
          user_course_subject_id: @user_course_subject.id, 
          task_id: user_task.id
        ).save!
      end
      flash[:success] = t "controllers.user_course_subject_controller.success"
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = t "controllers.course_controller.assign_trainee.f"
    ensure
      redirect_to trainee_course_subject_path @user_course_subject.course_subject_id
    end
  end

  private

  def load_user_course_subject
    @user_course_subject = UserCourseSubject.find_by id: params[:id]
    return if @user_course_subject

    flash[:danger] = t("controllers.user_course_subject_controller.error_show")
    redirect_to trainee_courses_path
  end

  def check_status_user_task
    status_subject =
      @user_course_subject.user_tasks.pluck(:status).include?("in_progress")
    return unless status_subject

    flash[:danger] = t("controllers.user_course_subject_controller.error_course")
    redirect_to trainee_course_subject_path @user_course_subject.course_subject.id
  end
end
