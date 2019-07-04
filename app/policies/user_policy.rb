class UserPolicy < ApplicationPolicy
  delegate :admin?, to: :user
  alias_method :edit_lessons?, :admin?
  alias_method :control_users?, :admin?

  def edit?
    update?
  end

  def update?
    user.id == record.id || user.admin?
  end

  def destroy?
    update?
  end

  # def control_users?
  #   user.admin?
  # end

  # def edit_lessons?
  #   user.admin?
  # end

  def new_lesson?
    user.admin?
  end

  def edit_form?
    user.admin?
  end

  def new_form?
    user.admin?
  end

  def user_admin?
    user.admin?
  end

  def is_teacher?
    user.user_type == 'teacher'
  end
end
