class FormsController < ApplicationController
  def show
    @form = Form.find params[:id]
    @students = User.all.select { |s| s.form_id == @form.id && s.user_type == 'student'}
  end

  def index
    @forms = Form.all.select {|f| f.id != 1 }
  end

  def new
    authorize current_user, :edit_form?
    @form = Form.new
  end

  def edit
    authorize current_user, :edit_form?
    @form = Form.find params[:id]
  end

  def update
    authorize current_user, :edit_form?
    @form = Form.find params[:id]
    if @form.update_attributes(updating_attribs)
      flash[:success] = 'Form updated!'
      redirect_to @form
    else
      flash[:danger] = 'Something goes wrong!'
      render 'edit'
    end
  end

  def create
    authorize current_user, :new_form?
    @form = Form.new(form_params)
    if @form.save
      if params[:form][:user_id] != ""
        @user = User.find params[:form][:user_id]
        @user.update_attribute(:form_id, @form.id)
      end
      flash[:success] = "Form created successfuly!"
      redirect_to forms_path
    else
      flash[:danger] = "Something goes wrong!"
      redirect_to forms_new_path
    end
  end

  def destroy
    authorize current_user, :edit_form?
    @form = Form.find(params[:id])
    if @form.users.count == 1
      if User.find(@form.user_id).update_attribute(:form_id, nil)
        if Form.find(params[:id]).destroy
          flash[:success] = "Form deleted"
        end
      end
    else
      flash[:danger] = 'Something goes wrong!'
    end
    redirect_to forms_path
  end

  private

  def updating_attribs
    params.require(:form).permit(:name)
  end

  def form_params
    params.require(:form).permit(:name, :user_id)
  end

end
