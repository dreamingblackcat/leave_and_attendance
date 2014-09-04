class LeaveDate < ActiveRecord::Base
  belongs_to :leave_period
  belongs_to :leave_application
end
