class LeaveDate < ActiveRecord::Base
  before_create :defaults
  belongs_to :leave_period
  belongs_to :leave_application
  delegate :user, :to => :leave_application, :allow_nil => false
  validates :date, presence: true
  # scope :eager_loaded_user, lambda{ User.pre_load}
  scope :half_leave_count, lambda {where leave_period.name == "morning" || leave_period.name == "afternoon"}
  scope :full_leave_count, lambda {where leave_period.name == "whole day"}
  # scope :granted, lambda {where(granted: true)}
  # scope :paid_leave, lambda{where(paid_leave: true)}
  #-TODO sanitize parameters passed to query methods
  def self.limit_by_year(year = Date.today.year)
  	start = Date.new(year.to_i,1,1)
  	finish = start.end_of_year
  	where(date: start..finish)
  end

  def self.limit_by_paid_leave(paid)
  	joins(:leave_application).where(leave_applications: {paid_leave: paid})
  end
  def self.limit_by_granted(granted)
  	where(granted: granted)
  end

  def self.limit_by_year_and_month(year =Date.today.year, month = Date.today.month)
  	start = Date.new(year.to_i,month.to_i,1)
  	finish = start.end_of_month
  	where(date: start..finish)
  end

  def self.leaves_count_hash(list,options={})
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
	  		list[key] = value.count.to_s.rjust(3,"0")
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
	 				list[year][month][day] = v.count.to_s.rjust(3,"0")
	 			end
	 		end
	 	end
	 	list
	 end

  end
  private
    def defaults
      self.granted = false
    end

end
