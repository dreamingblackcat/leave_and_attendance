class Employee::LeaveApplicationsController < Employee::BaseController
  
  def index
  	@leave_applications = @user.leave_applications.page(params[:page])
  end

  def new
  	@leave_application = @user.leave_applications.build
  end
end