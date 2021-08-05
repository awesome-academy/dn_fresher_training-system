class Trainer::TraineesController < Trainer::BaseController
  before_action :load_trainee, only: :show

  def show
    @course_subjects = @trainee.courses.find_by(id: params[:course_id]).course_subjects
                        .page(params[:page])
                        .per(Settings.courses.per_page)
    @course_user_subjects = @trainee.user_courses.find_by(course_id: params[:course_id]).user_course_subjects
  end

  private
  
  def load_trainee
    @trainee = User.find_by id: params[:id]
    return if @trainee

    flash[:danger] = t("controllers.course_controller.error_show")
    redirect_to trainer_course_path
  end
end
