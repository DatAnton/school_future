module UsersAndSubjectHelper
  def get_new_teacher_subjects(user_id)
    user = User.find user_id
    user_subjs = UsersAndSubject.all.where(user_id: user_id).index_by(&:subject_id)
    res = []
    subjs = Subject.all.select { |s| !user_subjs.include?(s.id) }
    subjs.each do |s|
      res << [s.name, s.id]
    end
    res
  end
end
