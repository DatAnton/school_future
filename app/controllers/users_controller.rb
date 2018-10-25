class UsersController < ApplicationController
  def profile
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
  end

  def control_users
    @users = []
    und_us = User.all.where(user_type: "undefined")
    und_us.each do |us|
      @users << us
    end
  end

  def lessons
    @user = current_user
    @subjects = [
      ["", "", "", "", ""],
      ["", "", "", "", ""],
      ["", "", "", "", ""],
      ["", "", "", "", ""],
      ["", "", "", "", ""],
      ["", "", "", "", ""],
      ["", "", "", "", ""],
      ["", "", "", "", ""]
    ]
    if @user.user_type == "student"
      @user.form.lessons.each do |less|
        @subjects[less.number - 1][less.day - 1] = less.subject.name
      end
    elsif @user.user_type == "teacher"
        teacher_lessons = Lesson.all.where(subject_id: @user.subjects)
        teacher_lessons.each do |less|
          @subjects[less.number - 1][less.day - 1] = "#{less.form.name}: #{less.subject.name}"
        end
    end
  end

  private

#maybe not need
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :remember_me)
  end
end
