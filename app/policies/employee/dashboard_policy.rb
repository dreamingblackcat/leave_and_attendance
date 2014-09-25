class DashboardPolicy < Struct.new(:user, :dashboard)

  def index?
    !@user.nil?
  end
  # ...
end