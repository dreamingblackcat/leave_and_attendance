class Employee::BaseController < ApplicationController
	layout "employee"
	before_filter :authenticate_and_get_user


	private 


	def authenticate_and_get_user
		@user = User.find(params[:user_id])
		unless @user === current_user
			raise Pundit::NotAuthorizedError
		end
	end

end