class LeaveDatesController < ApplicationController
	# GET /leave_applications/1/leave_date/new (AJAX)
	def show
		@leave_date = LeaveDate.find(params[:id])
	end
	
	
end