class LeaveDateRepository
	def self.filtered_leave_dates(params)
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

	def self.filtered_leave_dates_with_eager_loading(params)
		unless params.nil?
					if(params[:user_id])
						user = User.find(params[:user_id])
						leave_dates = user.leave_dates.eager_load(:leave_period).joins(leave_application: :user)
						leave_dates = leave_dates.limit_by_year(params[:year]) if params[:year]
						leave_dates = leave_dates.limit_by_paid_leave(params[:paid_leave]) if params[:paid_leave]
						leave_dates = leave_dates.limit_by_granted(params[:granted]) if params[:granted]
						leave_dates
					else 
						leave_dates = LeaveDate.all.eager_load(:leave_period).eager_load(leave_application: :user)
						leave_dates = leave_dates.limit_by_year(params[:year]) if params[:year]
						leave_dates = leave_dates.limit_by_paid_leave(params[:paid_leave]) if params[:paid_leave]
						leave_dates = leave_dates.limit_by_granted(params[:granted]) if params[:granted]
						leave_dates
					end

				else
					LeaveDate.all.eager_load(:leave_period).joins(leave_application: :user)
				end
	end
end