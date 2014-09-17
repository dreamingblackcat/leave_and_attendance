class LeaveAnalysisController < ApplicationController


	def index
		
		respond_to do|format|
			format.html do
				leave_dates_collection = LeaveDate.all
				@leaves = LeaveDate.leaves_count_hash(leave_dates_collection,format: "%Y-%m")
			end
			format.json do
				leave_dates_collection = filtered_leave_dates(params)
				render json: LeaveDate.leaves_count_hash(leave_dates_collection,format: "%Y-%m")
			end
		end
	end

	private

	def filtered_leave_dates(params)
		unless params.nil?
			if(params[:user_id])
				user = User.find(params[:user_id])
				leave_dates = user.leave_dates
				leave_dates = leave_dates.limit_by_year(params[:year]) if params[:year]
				leave_dates = leave_dates.limit_by_paid_leave(params[:paid_leave]) if params[:paid_leave]
				leave_dates = leave_dates.limit_by_granted(params[:granted]) if params[:granted]
				leave_dates
			else 
				leave_dates = LeaveDate.all
				leave_dates = leave_dates.limit_by_year(params[:year]) if params[:year]
				leave_dates = leave_dates.limit_by_paid_leave(params[:paid_leave]) if params[:paid_leave]
				leave_dates = leave_dates.limit_by_granted(params[:granted]) if params[:granted]
				leave_dates
			end

		else
			LeaveDate.all
		end
	end

end