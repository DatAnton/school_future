class UsersAndSubjectController < ApplicationController
  def set_teacher_subject
    @teachers = User.all.where(user_type: 'teacher')
  end

  def show

  end

  def new
    @relation = UsersAndSubject.new
  end

  def create
    @relation = UsersAndSubject.new(users_and_subject_params)
    if @relation.save
      flash[:success] = "Teacher's subject created successfuly!"
      redirect_to user_show_path @relation.user
    else
      flash[:danger] = "Smth went wrong!"
      redirect_to user_show_path @relation.user
    end
  end

  def destroy
    @relation = UsersAndSubject.find_by(subject_id: params[:subject_id], user_id: params[:user_id])
    user = @relation.user
    @lessons = Lesson.all.where(user_id: params[:user_id])
    # TODO: get rid of this
    @lessons.each do |l|
      l.user_id = 1
      l.save
    end
    @relation.destroy
    flash[:success] = "Teacher's subject deleted"
    redirect_to user_show_path(user)
  end

  private

  def users_and_subject_params
    params.require(:users_and_subject).permit(:user_id, :subject_id)
  end
end
