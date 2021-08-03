class Trainer::CoursesController < Trainer::BaseController
  before_action :load_course, only: [:show, :edit, :update]

  def index
    @courses = Course.created_desc.page(params[:page])
                     .per(Settings.courses.per_page)
  end

  def show
    load_trainers @course
    load_trainees @course
    load_subjects @course
  end

  def edit; end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new course_params

    if @course.save
      flash[:success] = t "courses.create.success"
      redirect_to trainer_courses_path
    else
      render :new
    end
  end

  def update
    if @course.update course_params
      flash[:success] = t "courses.update.success"
      redirect_to trainer_course_path
    else
      flash.now[:danger] = t "courses.update.failed"
      render :edit
    end
  end

  def start_course
    @course = Course.find_by id: params[:id]

    if @course.update status: "in_progress"
      @course.course_subjects.first.update status: "in_progress"
      redirect_to trainer_courses_path
      flash[:success] = t "courses.update.success"
    else
      flash[:danger] = t "courses.update.failed"
    end
  end

  private

  def course_params
    params.require(:course).permit(
      :name, :description, :status, :start_date, :end_date,
      subject_ids: [], user_ids: []
    )
  end

  def load_course
    @course = Course.find_by id: params[:id]
    return if @course

    flash[:danger] = t("controllers.course_controller.error_show")
    redirect_to trainer_courses_path
  end

  def load_trainers course
    @trainers = course.users.trainer.page(params[:page])
                      .per(Settings.courses.per_page)
  end

  def load_trainees course
    @trainees = course.users.trainee.page(params[:page])
                      .per(Settings.courses.per_page)
  end

  def load_subjects course
    @subjects = course.subjects.page(params[:page])
                      .per(Settings.courses.per_page)
  end
end
