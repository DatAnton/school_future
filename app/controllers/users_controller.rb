class UsersController < ApplicationController
  def profile
    @user = current_user
  end

  def edit
    authorize current_user, :edit?
    @user = User.find(params[:id])
    @forms = Form.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    authorize @user, :update?
    if @user.update_attributes(update_user_params)
      if @user.update_attributes(user_type: params[:user_type], form_id: params[:form_id])
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

  def control_all
    authorize User, :control_users?
    @users = User.all.select {|us| us.id != current_user.id && us.user_type != 'undefined' }
    @users_new_count = User.where(user_type: "undefined").length
  end

  def destroy_user
    authorize current_user, :destroy?
    if User.find(params[:id]).destroy
      flash[:success] = "User deleted"
      redirect_to users_control_all_path
    else
      flash[:danger] = 'Something goes wrong!'
      redirect_to users_control_all_path
    end
  end

  private

  def update_user_params
    if params[:user][:password] != '' && params[:user][:password_confirmation] != ''
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    else
      params.require(:user).permit(:first_name, :last_name, :email, :avatar)
    end
  end
end
