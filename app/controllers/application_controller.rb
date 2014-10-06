class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :authenticate_user!
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protect_from_forgery with: :exception
   private
   def after_sign_in_path_for(resource)
    unless resource.admin?
      employee_dashboard_path(user_id: resource.id)
    else
      users_path
    end
   end

    def user_not_authorized
      flash[:error] = "You are not authorized to perform this action."
      redirect_to(request.referrer || authenticated_root_path)
    end
    
end
