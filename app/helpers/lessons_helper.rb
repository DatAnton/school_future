module LessonsHelper
  def lesson_from_schedule(schedules, lesson_number)
    lesson = schedules&.find { |l| l.number == lesson_number }
    lesson ? lesson : ''
  end

  def get_subjects
    subjects = []
    s_db = Subject.all
    s_db.each do |s|
      subjects << [s.name, s.id]
    end
    subjects
  end

  def get_all_days
    [['Monday', 1], ['Tuesday', 2], ['Wednesday', 3], ['Thursday', 4], ['Friday', 5]]
  end

  def get_word_day(day)
    if day == 1
      'Monday'
    elsif day == 2
      'Tuesday'
    elsif day == 3
      'Wednesday'
    elsif day == 4
      'Thursday'
    elsif day == 5
      'Friday'
    end
  end

  def get_teachers
    teachers = []
    t_db = User.all.where(user_type: 'teacher')
    t_db.each do |t|
      teachers << ["#{t.first_name} #{t.last_name}", t.id]
    end
    teachers
  end
end
