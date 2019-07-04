module FormsHelper
  def find_name_class_teacher(form)
    teacher = User.find form.user_id
    name = "#{teacher.first_name} #{teacher.last_name}"
  end

  def get_free_teachers
    teachers = []
    t_db = User.all.where(user_type: 'teacher', form_id: 1)
    t_db.each do |t|
      teachers << ["#{t.first_name} #{t.last_name}", t.id]
    end
    teachers
  end

  def number_students(form)
    User.all.select{|s| s.form_id == form.id && s.user_type == 'student'}.count
  end
end
