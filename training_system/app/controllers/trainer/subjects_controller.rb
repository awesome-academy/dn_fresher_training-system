class Trainer::SubjectsController < Trainer::BaseController
  before_action :subject_params, :duration_task_valid, only: :create

  def new
    @subject = Subject.new
    @subject.tasks.build
  end

  def create
    @subject = Subject.new subject_params
    @subject.transaction do
      @subject.save!
      flash[:success] = t "controllers.subject_controller.create.success"
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = t "controllers.subject_controller.create.faild"
    ensure
      render :new
    end
  end

  private

  def subject_params
    params.require(:subject)
          .permit(:name, :description, :duration,
                  tasks_attributes: [:id, :name, :description, :duration])
  end

  def check_duration
    sum_duration_task = 0
    subject_params[:tasks_attributes].each do |task|
      sum_duration_task += task[1][:duration].to_i
    end
    sum_duration_task
  end

  def duration_task_valid
    if check_duration > subject_params[:duration].to_i
      flash[:danger] = t "controllers.subject_controller.create.duration"
      redirect_to new_trainer_subject_path
    end
  end
end
