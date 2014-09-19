class LeaveDateAnalyser

	def initialize(collection)
		@leave_dates = collection
	end

	# def get(style)
	# 	if style[:year] && style[:month] then
	# 		results = get_by_day
	# 	elsif( style[:month])
	# 	end

	# end

	def get_by_year_month_day
		results = @leave_dates.group_by do|ld|
			ld.date.strftime('%Y')
		end
		results.each do|year,lds|
			results[year] = lds.group_by do|ld|
				ld.date.strftime('%-m')
			end
		end
		results.each do|year,month_hashs|
			month_hashs.each do|month,lds|
				results[year][month] = lds.group_by do|ld|
					ld.date.strftime('%Y-%-m-%d')
				end
				results[year][month].each do|date,lds|
					results[year][month][date] = {
						half_leave_count: lds.select do|ld|
									ld.leave_period.name == "morning" || ld.leave_period.name == "afternoon"
								      end.count,
						full_leave_count: lds.select do|ld|
									ld.leave_period.name == "whole day"
								      end.count,
						users: get_users(lds)
					}
				end
			end
		end
		results


	end
	def get_by_month_day
		results = @leave_dates.group_by do|ld|
			ld.date.strftime('%-m')
		end
		results.each do|month,lds|
			results[month] = lds.group_by do|ld|
				ld.date.strftime('%Y-%-m-%d')
			end
		end
		results
	end

	def get_by_day
		results = @leave_dates.group_by do|ld|
			ld.date.strftime('%Y-%-m-%d')
		end
		results
	end
	private 

	def get_users(lds)
		lds.map{|ld| ld.user }
	end

end