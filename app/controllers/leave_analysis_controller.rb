class LeaveAnalysisController < ApplicationController


	def index
		@leaves = LeaveDate.leaves_count_hash(LeaveDate.all.order(:date),format: "%Y-%m")
		respond_to do|format|
			format.html
			format.json {render json: @leaves}
		end
	end
end