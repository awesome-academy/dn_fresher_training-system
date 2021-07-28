class Trainer::UserCoursesController < ApplicationController
  before_action :load_create_user_course, only: :create

  def create
    @trainee_assign = @course.user_courses.new user_id: params[:trainee_id],
                                              course_id: params[:format]
    if @trainee_assign.save
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
    trainee = User.find_by id: params[:trainee_id]
    course.users.destroy trainee
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
