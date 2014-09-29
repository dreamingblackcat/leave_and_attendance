class AddLeaveTypeIdToLeaveApplications < ActiveRecord::Migration
  def change
  	remove_column :leave_applications, :paid_leave,:boolean
  	add_column :leave_applications,:leave_type_id,:integer
  end
end
