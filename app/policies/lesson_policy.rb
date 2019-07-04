class LessonPolicy < ApplicationPolicy
  def edit?
    admin?
  end
end
