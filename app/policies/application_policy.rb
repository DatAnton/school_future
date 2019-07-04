class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  # private
  #
  # # delegate :admin?, to: :user
  # def admin?
  #   user.admin?
  # end
end
