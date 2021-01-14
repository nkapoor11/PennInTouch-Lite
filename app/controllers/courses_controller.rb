class CoursesController < ApplicationController
  before_action :authenticate_user
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :check_edit_authorization, only: [:edit, :update, :destroy]
  before_action :check_new_authorization, only: [:new, :create]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show 
  end

  # GET /courses/new
  def new  
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit 
  end

  # POST /courses
  # POST /courses.json
  def create
    
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        @course.users << current_user
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update   
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    authenticate_user
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:department_id, :code, :title, :description)
    end

    def check_edit_authorization
      redirect_to "/courses" unless current_user.is_instructor && @course.instructor.id == current_user.id
    end

    def check_new_authorization
      redirect_to "/courses" unless current_user.is_instructor
    end
end
