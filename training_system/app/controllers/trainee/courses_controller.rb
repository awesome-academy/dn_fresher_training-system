class Trainee::CoursesController < Trainee::BaseController
  before_action :load_course, :load_subjects, only: :show

  def index
    course_user = current_user.courses.page(params[:page])
                              .per(Settings.courses.per_page)
    @courses = course_user.search(params[:search])
  end

  def show; end

  private

  def load_course
    @course = current_user.courses.find_by id: params[:id]
    return if @course

    flash[:danger] = t("controllers.course_controller.error_show")
    redirect_to trainee_courses_path
  end

  def load_subjects
    @course_subjects = @course.course_subjects.page(params[:page])
                              .per(Settings.courses.per_page)
  end
end
