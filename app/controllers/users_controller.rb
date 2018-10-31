class UsersController < ApplicationController
  def profile
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
    authorize @user, :edit?
    @user.save
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    authorize @user, :update?
    if @user.update_attributes(update_user_params)
      if @user.update_attribute(:user_type, params[:user_type])
        flash[:success] = 'User profile updated'
        redirect_to users_control_all_path
      else
        flash[:danger] = 'There are a problem!'
        render 'edit'
      end
    else
      flash[:danger] = 'Something goes wrong!'
      render 'edit'
    end
  end

  def control_undef_users
    authorize User, :control_users?
    @users = User.where(user_type: "undefined")
    @users_new_count = User.where(user_type: "undefined").length
  end

  def control_students
    authorize User, :control_users?
    @users = User.all.select { |us| us.user_type == 'teacher' || us.user_type == 'student' }
    @users_new_count = User.where(user_type: "undefined").length
  end

  def control_all
    authorize User, :control_users?
    @users = User.all.select {|us| us.id != current_user.id }
    @users_new_count = User.where(user_type: "undefined").length
  end

  def edit_student
    authorize current_user, :edit?
    @forms = Form.all
    @user = User.find(params[:id])
  end

  def update_student_form
    @user = User.find(params[:id])
    authorize current_user, :update?
    f_id = Form.find_by(name: params["form_name"]).id
    if @user.update_attributes(update_user_params)
      @user.form_id = f_id
      if @user.save
        flash[:success] = "Student updated!"
        redirect_to users_control_students_path
      else
        flash[:danger] = 'Something goes wrong!'
        render 'edit_student'
      end
    else
      flash[:danger] = 'Something goes wrong!'
      render 'edit_student'
    end
  end

  def destroy_user
    authorize @user, :destroy?
    if User.find(params[:id]).destroy
      flash[:success] = "User deleted"
      redirect_to users_control_all_path
    else
      flash[:danger] = 'Something goes wrong!'
      redirect_to users_control_all_path
    end
  end

  def lessons
    @user = current_user
    @objects = if current_user.user_type == "student"
      current_user.form.lessons.group_by(&:day)
    elsif current_user.user_type == "teacher"
      Lesson.where(subject_id: current_user.subjects).group_by(&:day)
    end
  end

  private

  def update_user_params
    if params[:user][:password] != '' && params[:user][:password_confirmation] != ''
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    else
      params.require(:user).permit(:first_name, :last_name, :email)
    end
  end
end
