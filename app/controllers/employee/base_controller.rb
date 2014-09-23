class Employee::BaseController < ApplicationController
	layout "employee"
	before_filter :get_user


	private 

	def get_user
		@user = User.find(params[:user_id])
	end
end