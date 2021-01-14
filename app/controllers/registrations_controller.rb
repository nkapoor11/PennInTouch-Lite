class RegistrationsController < ApplicationController
  before_action :authenticate_user
  before_action :set_course
  before_action :set_user

  def add_course
    # TODO: Drop course and redirect to @user
    # Reminder: be sure to check if 
    # 1) @user is a student
    # 2) @user is NOT registered to the @course
    
    if @user == current_user 
      @course.users << @user unless @user.is_instructor || @course.students.include?(@user)
    end
    redirect_to @user
  end

  def drop_course
    # TODO: Drop course and redirect to @user
    # Reminder: be sure to check if 
    # 1) @user is a student
    # 2) @user is registered to the @course
    if @user == current_user 
      @course.users.delete(@user) unless @user.is_instructor
    end
    redirect_to @user
  end

  private
  
  def set_course
    # TODO: find the course using `course_id`
    @course = Course.find(params[:course_id])
  end

  def set_user
    # TODO: find the user using `course_id`
    @user = User.find(params[:user_id])
  end
end