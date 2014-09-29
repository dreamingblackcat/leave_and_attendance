def rand_string(size,range)
	base = ""
	size.times do
		base.concat(range.to_a.sample.to_s)
	end
	base
end

namespace :seeder do
  desc "Seed User table"
  task user: [:environment, :team] do
  	User.destroy_all
  	10.times do |i|
	  	user = User.new
	  	user.name = "user#{i}"
	  	user.email = "#{user.name}@gmail.com"
	  	user.password = user.name
	  	user.password_confirmation = user.password
	  	user.joined_date = rand((3.years.ago)..(0.years.ago))
	  	user.nrc_number = "#{rand(1..14)}/#{rand_string(3,("a".."z"))}(n)#{rand_string(6,(1..9))}"
	  	user.bank_card_number = "#{rand_string(12,(1..9))}"
	  	user.date_of_birth = (rand(20..30).years.ago - rand(10..300).days).to_date
	  	user.employee_no = "AW-#{i}"
	  	user.nationality = ["Myanmar","Japan","Karen","Shan","Chin"].sample
	  	user.religion = ["Buddhist", "Christian", "Islam", "Hindu"].sample
	  	user.gender = ["Male", "Female"].sample
	  	user.address = "User #{i} address"
	  	user.phone_no = rand(10000..20000)
	  	user.team_id = Team.all.sample.id
	  	user.blood_type = ["A", "AB", "O", "B"].sample
	  	user.save!
	  	puts "Saving user#{i}"
	end 
  end

  desc "Seed Team table"
  task team: :environment do
  	Team.destroy_all
  	10.times do |i|
  		team = Team.new
  		team.name = "team#{i}"
  		team.save!
  		puts "Saved team#{i}"
  	end
  end

  task leave_application: [:user,:leave_type,:environment] do
  	LeavePeriod.destroy_all
  	LeaveDate.destroy_all
  	LeaveApplication.destroy_all
  	lps = []
  	lps.push LeavePeriod.create!(name: "morning", start_time: "9:00AM",end_time: "12:00PM")
  	lps.push LeavePeriod.create!(name: "afternoon", start_time: "12:00PM",end_time: "5:30PM")
  	lps.push LeavePeriod.create!(name: "whole day", start_time: "9:00AM",end_time: "5:30PM")
  	lts = LeaveType.all
 	User.all.each do|user|
 		rand(10..20).times do|i|
	 		la = LeaveApplication.new
	 		la.user_id = user.id
	 		la.application_date = rand(1.years.ago.to_date..Date.today)
	 		la.reason = "Some random reason #{i}"
	 		la.leave_type_id = lts.sample.id
	 		la.save!
	 		puts "Saved a leave applicatoin for #{user}"
	 		rand(1..3).times do|j|
	 			ld = LeaveDate.new
	 			ld.date = la.application_date + j+1
	 			ld.granted = true
	 			ld.leave_period_id = lps.sample.id
	 			ld.leave_application_id = la.id
	 			ld.save!
	 		end
	 	end
 	end
  end

  task leave_type: :environment do
  	LeaveType.destroy_all
  	LeaveType.create(name: "Paid Leave")
  	LeaveType.create(name: "Normal Leave")
  end

end
