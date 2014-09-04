class LeaveApplication < ActiveRecord::Base
  belongs_to :user
  has_many :leave_dates, dependent: :destroy
  accepts_nested_attributes_for :leave_dates, allow_destroy: true
end
