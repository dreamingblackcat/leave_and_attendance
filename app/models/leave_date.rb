class LeaveDate < ActiveRecord::Base
  belongs_to :leave_period
  belongs_to :leave_application
  scope :granted, lambda {where(granted: true)}
  def self.limit_by_year(year = Date.today.year)

  	start = Date.new(year,1,1)
  	finish = start.end_of_year
  	where(date: start..finish)
  end

  def self.limit_by_month_and_year(month = Date.today.month,year =Date.today.year)
  	start = Date.new(year,month,1)
  	finish = start.end_of_month
  	where(date: start..finish)
  end
  def get_year
  	self.date.year
  end

  def self.leaves_count_for_each_date(list,options={})
  	default_options = {
  		year_limit: Date.today.year,
  		format: "%Y-%-m-%d"
  	}
  	options = default_options.merge(options)
  	unless options[:format] == :nested then
	  	list = list.group_by do |record|
	  		record.date.strftime(options[:format])
	  	end
	  	list.each do|key,value|
	  		list[key] = value.count
	  	end
	  	list
	 else
	 	list = list.group_by do|record|
	 		record.date.year
	 	end
	 	list.each do|year,value|
	 		list[year] = value.group_by do|record|
	 			record.date.month
	 		end
	 		list[year].each do|month,val|
	 			list[year][month] = val.group_by do|record|
	 				record.date.day
	 			end
	 			list[year][month].each do|day,v|
	 				list[year][month][day] = v.count
	 			end
	 		end
	 	end
	 	list
	 end

  end

end
