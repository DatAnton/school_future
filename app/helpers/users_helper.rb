module UsersHelper
  def lesson_from_schedule(schedules, lesson_number)
    lesson = schedules&.find { |l| l.number == lesson_number }
    lesson ? lesson.subject.name : ''
  end

  def build_form_arr(forms)
    form = []
    forms.each do |f|
      form << f.name
    end
    form
  end

  def find_form(user)
    form = Form.find(user.form_id)
    form.name
  end
end
