class AddTotalHoursToLeavePeriods < ActiveRecord::Migration
  def change
  	add_column :leave_periods, :total_hours, :decimal
  end
end
