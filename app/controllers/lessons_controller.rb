class LessonsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index_admin
    @form = Form.find params[:form_id]
    @lessons = Lesson.where(form_id: @form.id).group_by(&:day)
  end
  
  def index
    @user = current_user
    if current_user.user_type == 'student'
      @objects = current_user.form.lessons.group_by(&:day)
      @form = current_user.form
    elsif current_user.user_type == 'teacher'
      @objects = Lesson.where(user_id: current_user.id).group_by(&:day)
      @form = ''
    elsif current_user.user_type = 'admin'
      authorize current_user, :edit_lessons?
      @form = Form.find(params[:form_id])
      @objects = @form.lessons.group_by(&:day)
    end

    scope = case current_user.user_type
            when 'student'
              # @form = current_user.form
              current_user.form.lessons
            when 'teacher'
              Lesson.where(user_id: current_user.id)
              # @form = ''
            when 'admin'
              # @form = Form.find(params[:form_id])
              Lesson.where(form_id: params[:form_id])
            end

    @objects = scope.group_by(&:day)
  end

  def get_teachers_of_subject
    # @selected_users = []
    # @lesson = Lesson.find params[:lesson_id]
    # @subject = Subject.find params[:subject_id]
    # @selected_users << @lesson.user if @lesson.user.user_type == 'teacher'
    #
    # @subject.users.each do |user|
    #   if User.is_free_for_lessons?(user.lessons, @lesson)
    #     puts "YES"
    #     @selected_users << user
    #   end
    # end
    # render json: @selected_users
    @subject = Subject.find params[:subject_id]
    render json: @subject.users
  end

  def list_form_lessons
    authorize current_user, :edit_lessons?
    @forms = Form.all[1..Form.all.size]
  end

  def new
    authorize current_user, :new_lesson?
    @lesson = Lesson.new
  end

  def create
    authorize current_user, :new_lesson?
    @lesson = Lesson.new(lesson_params)
    if @lesson.save
      flash[:success] = "OK"
      redirect_to lessons_index_path(form_id: params[:lesson][:form_id])
    else
      flash[:danger] = 'Something goes wrong!'
      render 'new'
    end
  end

  def destroy
    authorize current_user, :edit_lessons?
    @lesson = Lesson.find(params[:id])
    form_id = @lesson.form_id
    @lesson.destroy
    flash[:success] = "Lesson deleted"
    redirect_to lessons_index_path(form_id: form_id)
  end

  def show
    @lesson = Lesson.find(params[:id])
    @homework = @lesson.homeworks.last
    respond_to do |format|
      format.html {  }
      format.json  { render json: @lesson }
    end
  end

  def edit
    authorize current_user, :edit_lessons?
    @lesson = Lesson.find(params[:id])
  end

  def update
    authorize current_user, :edit_lessons?
    @lesson = Lesson.find(params[:id])
    if @lesson.update_attributes(subject_id: params[:subject_id], user_id: params[:user_id])
      render json: @lesson, status: :ok
    else
      render json: @lesson
    end
  end

  private

  def lesson_params
    params.require(:lesson).permit(:number, :day, :subject_id, :user_id, :form_id)
  end
end
