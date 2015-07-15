class ApplicationCaseMailer < ApplicationMailer

	def new_note_notification(user, message, sender, application)
		@user = user.contact.full_name
		@message = message
		@sender = sender.contact.full_name
		@application = application

		mail( :to => "#{user.contact.full_name} <#{user.email}>", :subject => "New Note" )
	end

	def status_change(user, status, application)
		@user = user.contact.full_name
		@status = status
		@application = application

		mail( :to => "#{user.contact.full_name} <#{user.email}>", :subject => "Status Change" )
	end

	def new_requirement_added(user, requirement, sender, application)
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

		mail( :to => "#{user.contact.full_name} <#{user.email}>", :subject => "New Requirement" )
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
		
		mail( :to => "#{user.contact.full_name} <#{user.email}>", :subject => "Requirement Updated" )
	end


end
