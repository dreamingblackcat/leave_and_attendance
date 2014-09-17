module Api
	class LeaveDatesController < ApplicationController

		respond_to :json

		def index
			la = LeaveDateAnalyser.new(LeaveDateRepository.filtered_leave_dates_with_eager_loading(params))
			render json: la.get_by_year.to_json
		end
	end
end