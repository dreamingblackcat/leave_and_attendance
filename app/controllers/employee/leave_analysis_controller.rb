class Employee::LeaveAnalysisController < Employee::BaseController

	def index
		@chart_element = "user-leave-count-chart"
	end

end