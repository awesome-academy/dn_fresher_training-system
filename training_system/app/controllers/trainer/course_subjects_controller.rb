class Trainer::CourseSubjectsController < ApplicationController
  before_action :load_create_user_course, only: :create

  def create
    @subject_add = @course.course_subjects.new subject_id: params[:subject_id],
                                              course_id: params[:format]
    if @subject_add.save
      flash[:success] = t "controllers.course_controller.assign_trainee.suc"
      redirect_to edit_trainer_course_path @course.id
    else
      flash.now[:danger] = t "controllers.course_controller.assign_trainee
                                                           .failed"
      render :edit
    end
  end

  def destroy
    course = Course.find_by id: params[:id]
    subject = Subject.find_by id: params[:subject_id]
    course.subjects.destroy subject
    flash[:success] = t "controllers.course_controller.remove_trainee.success"
    redirect_to edit_trainer_course_path course.id
  end

  private

  def load_create_user_course
    @course = Course.find_by id: params[:format]
    return if @course

    flash.now[:danger] = t "controllers.course_controller.error_show"
    render :edit
  end
end
