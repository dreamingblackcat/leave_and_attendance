class LeaveAnalysisController < ApplicationController


	def index
		
		respond_to do|format|
			format.html do
				leave_dates_collection = LeaveDate.all
				@leaves = LeaveDate.leaves_count_hash(leave_dates_collection,format: "%Y-%m")
			end
			format.json do
				leave_dates_collection = LeaveDateAnalyser.filtered_leave_dates(params)
				render json: LeaveDate.leaves_count_hash(leave_dates_collection,format: "%Y-%m")
			end
		end
	end

end