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

end
