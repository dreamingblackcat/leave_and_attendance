class LeaveAnalysisController < ApplicationController


	def index
		@leaves = LeaveDate.leaves_count_hash(LeaveDate.all.order(:date),format: "%Y-%m")
	end
end