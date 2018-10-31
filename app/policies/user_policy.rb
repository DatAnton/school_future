class UserPolicy < ApplicationPolicy
  def edit?
    update?
  end

  def update?
    user.id == record.id || user.admin?
  end

  def destroy?
    update?
  end

  def control_users?
    user.admin?
  end
end
