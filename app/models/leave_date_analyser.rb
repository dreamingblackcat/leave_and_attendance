class LeaveDateAnalyser

	def initialize(collection)
		@leave_dates = collection
	end

	def get(options)
		meta = options[:meta] || false
		if options[:year].nil? 
			get_by_year_month_day(meta)
		else
			if(options[:month]).nil? 
				get_by_month_day(meta)
			else
				get_by_day(meta)
			end	
		end		
	end

	def get_by_year_month_day(meta)
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
					results[year][month][date] =  meta ? get_leave_count_hash(lds) : lds
				end
			end
		end
		results


	end
	def get_by_month_day(meta)
		results = @leave_dates.group_by do|ld|
			ld.date.strftime('%-m')
		end
		results.each do|month,lds|
			results[month] = lds.group_by do|ld|
				ld.date.strftime('%Y-%-m-%d')
			end

			results[month].each do|date,lds|
				results[month][date] = meta ? get_leave_count_hash(lds) : lds
			end
		end
		results
	end

	def get_by_day(meta)
		results = @leave_dates.group_by do|ld|
			ld.date.strftime('%Y-%-m-%d')
		end
		results.each do|date,lds|
			results[date] = meta ? get_leave_count_hash(lds): lds
		end
		results
	end

	def get_by_year(meta)
		results = @leave_dates.group_by do|ld|
			ld.date.strftime("%-m")
		end
		results.each do|month,lds|
			results[month] = meta ? get_leave_count_hash(lds) : lds
		end
		results
	end

	def get_by_year_month(meta)
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
				results[year][month] = meta ? get_leave_count_hash(lds) : lds
			end
		end
	end

	private 

	# def transform_yearly_hash(collection)
	# 	collection = collection.group_by do|ld|
	# 		ld.date.strftime('%Y')
	# 	end
	# 	collection
	# end

	# def transform_yearly_monthly_hash(collection)
	# 	collection.each do|year,lds|
	# 		collection[year] = lds.group_by do|ld|
	# 			ld.date.strftime('%-m')
	# 		end
	# 	end
	# 	collection
	# end

	# def transform_yearly_monthly_daily_hash(collection)
	# 	collection.each do|year,month_hashs|
	# 		month_hashs.each do|month,lds|
	# 			collection[year][month] = lds.group_by do|ld|
	# 				ld.date.strftime('%Y-%-m-%d')
	# 			end
	# 		end
	# 	end
	# end

	def get_users(lds)
		lds.each do|ld|
			puts ld
		end
		hls = lds.select do|ld|
			ld.leave_period.name == "morning" || ld.leave_period.name == "afternoon"
		end
		fls = lds - hls
		{
			half_leave: hls.map{|ld| ld.user},
			full_leave: fls.map{|ld| ld.user}
		}
	end

	def get_leave_count_hash(lds)
		{
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