class ApplicationCaseMailer < ApplicationMailer


	#  Note mailers 

	def new_note_notification(user, message, sender, application)
		@user = user.contact.full_name
		@message = message
		@sender = sender.contact.full_name
		@application = application

		mail( :to => "ross@pixeldotcreative.com", :subject => "New Note" )
	end

	def multiple_note_notification(user, messages, sender, application)
		@user = user.contact.full_name
		@messages = messages
		@sender = sender.contact.full_name
		@application = application

		mail( :to => "ross@pixeldotcreative.com", :subject => "New Note" )
	end


	# Status change mailer

	def status_change(user, status, application)
		@user = user.contact.full_name
		@status = status
		@application = application

		mail( :to => "ross@pixeldotcreative.com", :subject => "Status Change" )
	end


	# Requirement mailers 

	def new_requirements_added(user, requirements, sender, application)
		@user = user.contact.full_name
		@application = application
		@requirements = requirements
		@sender = sender.contact.full_name		

		mail( :to => "ross@pixeldotcreative.com", :subject => "New Requirement" )
	end

	def requirement_update(user, requirement, sender, application)
		@user = user.contact.full_name
		@application = application
		@requirement = requirement
		@sender = sender.contact.full_name
		@req_status = @requirement.status
		@date = @requirement.date_requested

		if @requirement.requirement.nil? 
         	@req = requirement.free_requirement 
        elsif 
          	@req = requirement.requirement.requirment 
        end 
		
		mail( :to => "ross@pixeldotcreative.com", :subject => "Requirement Updated" )
	end

	
	# applicant mailer

	def notify_new_applicant(user, sender, application_case)
		@user = user.contact.full_name
		@application = application_case
		@sender = sender.contact.full_name

		mail( :to => "ross@pixeldotcreative.com", :subject => "Added to Case" )
		
	end

	def notify_removed_applicant(user, sender, application_case)
		@user = user.contact.full_name
		@application = application_case.case_ref
		@sender = sender.contact.full_name

		mail( :to => "ross@pixeldotcreative.com", :subject => "Removed from Case" )

	end

	# Agent mailer 

	def notify_new_agent(user, sender, application_case) 
		@user = user.contact.full_name
		@application = application_case
		@sender = sender.contact.full_name
		
		mail( :to => "ross@pixeldotcreative.com", :subject => "Added to Case" )
	end

	def notify_removed_agent(user, sender, application_case) 
		@user = user.contact.full_name
		@application = application_case.case_ref
		@sender = sender.contact.full_name

		mail( :to => "ross@pixeldotcreative.com", :subject => "Removed from Case" )
	end


	# New user mailer

	def new_user_and_password_notification(user, current_user, password)
		@user = user
		@password = password
		@sender = current_user

		mail( :to => "ross@pixeldotcreative.com", :subject => "New user registration" )
	end

	def added_as_agent(user, client)
		@user = user
		@client = client

		mail( :to => "ross@pixeldotcreative.com", :subject => "New user registration" )
	end


	# Digest emails. 

	def digest(user, cases)
		@user = user
		@cases = cases

		mail( :to => "ross@pixeldotcreative.com", :subject => "Mortgage|aide Digest" )
	end
end
