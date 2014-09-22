class LeaveDatesController < ApplicationController
	# GET /leave_applications/1/leave_date/new (AJAX)
	def new
	  @leave_date = LeaveDate.create!
	  new_child_form = render_to_string :layout => false
	  new_child_form.gsub!("[#{@leave_date.id}]", "[#{Time.now.to_i}]")
	  render :text => new_child_form, :layout => false
	end
	 
	# DELETE /leave_applications/1/leave_date/1 (AJAX)
	def destroy
	  leave_application = LeaveApplication.find(params[:leave_application_id])
	  unless leave_application.leave_date.exists?(params[:id])
	    render :text => { :success => false, :msg => 'the child was not found.' }.to_json and return
	  end
	  if leave_application.leave_date.destroy(params[:id])
	render :text => { :success => true }.to_json
	  else
	    render :text => { :success => false, :msg => 'something unexpected happened.' }.to_json
	  end
	end
	
	
end