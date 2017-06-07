namespace :db do
	desc "Erase and fill database"
	# creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
	task :populate => :environment do
		# Docs at: http://faker.rubyforge.org/rdoc/
	    #require 'faker'
	    #require 'factory_girl_rails'
	    
	    # Step 0: drop old databases and rebuild
	    Rake::Task['db:drop'].invoke
	    Rake::Task['db:create'].invoke
	    Rake::Task['db:migrate'].invoke
	    #Rake::Task['db:test:prepare'].invoke

	    # Creating users
	    admin = User.new
	    admin.first_name = 'Jason' 
	    admin.last_name = 'Chen'
	    admin.email = 'admin@gmail.com'
	   	admin.password = 'manna'
	   	admin.password_confirmation = 'manna'
	   	admin.phone = '4124788458'
	   	admin.role = 'admin'
	   	admin.active = true
	   	admin.save!

		staff = User.new
	    staff.first_name = 'Ikane' 
	    staff.last_name = 'Manage'
	    staff.email = 'staff@gmail.com'
	   	staff.password = 'manna'
	   	staff.password_confirmation = 'manna'
	   	staff.phone = '4124788458'
	   	staff.role = 'staff'
	   	staff.active = true
	   	staff.save!

	   	head = User.new
	    head.first_name = 'Heidi' 
	    head.last_name = 'Deekon'
	    head.email = 'head_deacon@gmail.com'
	   	head.password = 'manna'
	   	head.password_confirmation = 'manna'
	   	head.phone = '4124788458'
	   	head.role = 'head_deacon'
	   	head.active = true
	   	head.save!

	   	care = User.new
	    care.first_name = 'Claire' 
	    care.last_name = 'Deekon'
	    care.email = 'care_deacon@gmail.com'
	   	care.password = 'manna'
	   	care.password_confirmation = 'manna'
	   	care.phone = '4124788458'
	   	care.role = 'care_deacon'
	   	care.active = true   	
	   	care.save!

	   	finance = User.new
	    finance.first_name = 'Finn' 
	    finance.last_name = 'Nance'
	    finance.email = 'financial_deacon@gmail.com'
	   	finance.password = 'manna'
	   	finance.password_confirmation = 'manna'
	   	finance.phone = '4124788458'
	   	finance.role = 'financial_deacon'
	   	finance.active = true 
	   	finance.save!

	    care2 = User.new
	    care2.first_name = 'Ally' 
	    care2.last_name = 'Sorge'
	    care2.email = 'ally@gmail.com'
	   	care2.password = 'manna'
	   	care2.password_confirmation = 'manna'
	   	care2.phone = '4124788458'
	   	care2.role = 'care_deacon'
	   	care2.active = true
	   	care2.save!

	   	care3 = User.new
	    care3.first_name = 'Sina' 
	    care3.last_name = 'Siddiqi'
	    care3.email = 'sina@gmail.com'
	   	care3.password = 'manna'
	   	care3.password_confirmation = 'manna'
	   	care3.phone = '4124788458'
	   	care3.role = 'care_deacon'
	   	care3.active = false    
	   	care3.save!

	    # Creating some cases
	    case1 = Case.new
	    case1.client_name = 'John Doe'
	    case1.date_submitted = Date.today.to_date
	    case1.summary = '$1000 needed ASAP.'
	    case1.notes = 'Client has not paid bill in several months. Needs urgent attention.'
	    case1.status = 'submitted'
	    case1.deacon_id = care.id
	    case1.subject = 'Paying Medical expenses' 
	    case1.save!

	    case2 = Case.new
	    case2.client_name = 'John Doe'
	    case2.date_submitted = Date.today.to_date
	    case2.summary = '$200 needed ASAP.'
	    case2.notes = 'Client needs money for food.'
	    case2.status = 'check_processed'
	    case2.deacon_id = care2.id
	    case2.subject = 'Paying for food' 
	    case2.save!

	end
end