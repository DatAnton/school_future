module GradesHelper
  def get_teacher_subject
    @subjs = current_user.subjects
    @result = []
    @subjs.each do |s|
      @result << [s.name, s.id]
    end
    @result
  end

  def get_student_grades(user, subject)
    grades = Grade.all.where(user_id: user, subject_id: subject).select { |x| x.updated_at > Date.today - 7 }
    res = []
    (1..7).each do |i|
      grade = grades.select{|g| g.created_at.day == DateTime.now.day - (i-1)}
      if grade.nil?
        res << ''
      elsif grade.class == Array
        res << form_str_grade(grade)
      end
    end
    res.reverse!
    puts res
    res
  end

  def form_str_grade(arr)
    str = ''
    arr.each do |g|
      str += "#{g.grade}, "
    end
    str[0, str.length-2]
  end

  def get_last_7_days
    arr = []
    (1..7).each do |i|
      arr << DateTime.now - i
    end
    arr.reverse!
    arr
  end


end
