class HomeworksController < ApplicationController
  def new
    @homework = Homework.new
  end

  def create
    authorize current_user, :is_teacher?
    @homework = Homework.new(homework_params)
    if @homework.save
      flash[:success] = 'Homework created!'
      redirect_to lesson_path @homework.lesson
    else
      flash[:danger] = 'Something went wrong'
      redirect_to homework_new_path
    end
  end

  def edit
    authorize current_user, :is_teacher?
    @homework = Homework.find params[:homework_id]
    @lesson = Lesson.find params[:id]
  end

  def update
    authorize current_user, :is_teacher? 
    @homework = Homework.find params[:id]
    if @homework.update_attributes(homework_params)
      flash[:success] = 'Homework updated!'
    else
      flash[:danger] = 'Something went wrong'
    end
    redirect_to lesson_path @homework.lesson
  end

  private

  def homework_params
    params.require(:homework).permit(:homework, :lesson_id)
  end
end
