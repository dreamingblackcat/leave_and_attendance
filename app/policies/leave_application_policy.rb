class LeaveApplicationPolicy < ApplicationPolicy
  def initialize(user,leave_application)
  	@user = user
  	@leave_application = leave_application
  end

  def index?
    !@user.nil?
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    !@user.nil?
  end

  def new?
    create?
  end

  def update?
    !@user.nil?
  end

  def edit?
    update?
  end

  def destroy?
        !@user.nil?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end
end
