class LeaveDateFinder
	attr_reader :leave_dates
	def initialize(filters)
		filters = {}  if filters.nil?
		general_filter_list = [:year,:granted,:paid_leave]
		@general_filters = filters.slice!(@general_filter_list)
		if filters[:user_id]
				leave_dates = User.find(filters[:user_id]).leave_dates
				@leave_dates = apply_general_filter(@leave_dates)
		else
			@leave_dates = apply_general_filter(LeaveDate.all)
		end
	end

	private
		def apply_general_filter(collection)
			unless @general_filters.empty?
				@general_filters.each do|filter,value|
					collection = collection.send("limit_by_#{filter}".to_sym,value)
				end
			end
			collection
		end

end