class GradesController < ApplicationController
  def new
    @grade = Grade.new
  end

  def create
    authorize current_user, :is_teacher?
    @grade = Grade.new(grade_params)
    if @grade.save
      flash[:success] = 'Grade was setted!'
      user = User.find(params[:grade][:user_id])
      redirect_to grades_path form_id: user.form.id, subject_id: params[:grade][:subject_id]
    else
      flash[:danger] = 'Smth goes wrong!'
    end
  end

  def list_form
    @forms = Form.all[1..Form.all.length]
  end

  def list_subject
    @form = params[:form_id]
    @subjects = form_subjects_of_form(Form.find @form)
  end

  def index
    @form = Form.find(params[:form_id])
    @subject = Subject.find(params[:subject_id])
    @students = User.all.where(form_id: @form.id, user_type: 'student')
  end

  def index_for_student
    @subjects = form_subjects_of_form(current_user.form)
  end

  private

  def grade_params
    params.require(:grade).permit(:grade, :user_id, :subject_id)
  end

  def form_subjects_of_form(form)
    subs = []
    form.lessons.each do |l|
      s = Subject.find l.subject.id
      if !(subs.include? s)
        subs << s
      end
    end
    subs
  end
end
