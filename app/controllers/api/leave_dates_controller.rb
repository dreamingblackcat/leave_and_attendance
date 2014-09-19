module Api
	class LeaveDatesController < ApplicationController

		respond_to :json

		def index
			la = LeaveDateAnalyser.new(LeaveDateRepository.filtered_leave_dates_with_eager_loading(params))
			if(params[:year].nil?) then
				render json: la.get_by_year_month_day.to_json
			else
				if(params[:month].nil?) 
					render json: la.get_by_month_day.to_json
				else
					render json: la.get_by_day.to_json
				end
			end
		end
	end
end