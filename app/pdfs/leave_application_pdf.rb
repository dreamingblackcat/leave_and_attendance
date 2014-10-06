class LeaveApplicationPdf < Prawn::Document

	def initialize(leave_application,leave_dates,user)
		super(topmargin: 50)
		@leave_application = leave_application
		@leave_dates = leave_dates
		@user = user
		get_pdf
	end

	def get_pdf
		define_grid(:columns => 3, :rows => 5, :gutter => 10)
		grid(0,0).bounding_box do
		  formatted_text [text: "To: Ms. Thida Aung",styles: [:underline]]
		end
		grid([0,1],[0,2]).bounding_box do
			table([
				["Date:"," #{@leave_application.application_date}"],
				["Date of Submission:"," #{@leave_application.created_at.to_date}"],
				["ID:","#{@user.employee_no}"],
				["Name:","#{@user.name}"]
				   ], cell_style: {align: :right,shrink_to_fit: true,:border_color => "FFFFFF"},position: :right) do
				columns(1).align = :center
				columns(1).font_style = :italic
			end
		end
		grid(0,1).bounding_box do
			text "<u>Report</u>", :align => :center, :valign => :bottom,:inline_format => true
		end
		data = [
			["", "Special Paid Leave", {content: "Date",rowspan: 2},"From       #{from_date}",{content: "#{total_days} days",rowspan: 2}],
			["", "Paid Holiday","To            #{to_date}"],
			["","Absence",{content: "Time",rowspan: 2},"From        #{from_time}",{content: "#{total_hours} hours",rowspan: 2}],
			["","Tardy","To             #{to_time}"],
			["","Early Leaving",{content: "Reason \n\n#{reason}",rowspan: 7,colspan: 3}],
			["","Delay"],
			["","Holiday Work"],
			["","Compensation Day"],
			["","Early Attendance"],
			["","Overtime Work"],
			["","Going Out"],
			["","Business Trip",{content: "",colspan: 3}],
			]
		grid([1,0],[3,2]).bounding_box do
			table(data,:column_widths => [30, 100, 50,180,180]) do
				columns(4).align = :right
			end
			move_down 40
			text "% Please check the applicable box."
		end

		grid(4,2).bounding_box do
			text "Sign: #{signature}"
		end
	end


	private

	def from_date
		first_leave_date.date
		# "2014 April 4"
	end

	def to_date
		last_leave_date.date
	end

	def first_leave_date
		@leave_dates.first
	end

	def last_leave_date
		@leave_dates.last
	end

	def from_time
		first_leave_date.leave_period.start_time
	end

	def to_time
		last_leave_date.leave_period.end_time
	end

	def total_hours
		@leave_dates.reduce(0) do|res,ld|
			res = res + ld.leave_period.total_hours
		end
	end

	def total_days
		total_hours / 7.5 # magic number, it must somehow be replaced
	end

	def reason
		"<div>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Porro veritatis quis debitis impedit quae tenetur dolor recusandae, expedita nulla culpa totam dolore nesciunt itaque unde pariatur rem qui accusamus odit!</div><div>Possimus repellat, amet ut corporis quidem iusto voluptatibus at dolores nulla consectetur provident necessitatibus tempora omnis sunt commodi quasi dolorum laudantium aspernatur ad! Cum, culpa nostrum at accusamus, dicta unde?</div><div>Harum, suscipit quia dolorum voluptates explicabo rem velit nisi minima? Dolorem a veritatis non officiis quaerat eos distinctio hic esse, quisquam impedit, eum ipsum quia rerum fugit inventore, unde dicta!</div><div>Vitae modi, quas, laudantium debitis et quam delectus praesentium atque eligendi facilis perferendis eos itaque quaerat adipisci, laboriosam deserunt reiciendis iusto porro? Enim quidem molestias iste laudantium. Totam veritatis, accusantium?</div>"
	end

	def signature
		@user.name
	end

end