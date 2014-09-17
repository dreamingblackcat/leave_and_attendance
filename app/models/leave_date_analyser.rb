class LeaveDateAnalyser

	def initialize(collection)
		@leave_dates = collection
	end

	def get_by_year
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

	private 

	def get_users(lds)
		lds.map{|ld| ld.user }
	end

end