desc "Sends a daily digest to users"

task :send_digest => :environment do
  
  @agents = User.agents
  @brokers = User.brokers

  @agents.try(:each) do |agent|
  	@cases = agent.application_cases.active_and_offered
  	if @cases.count != 0 
    	ApplicationCaseMailer.digest(agent, @cases).deliver
    end
  end

  @brokers.try(:each) do |broker|
  	@cases = broker.application_cases.active_and_offered
  	if @cases.count != 0 
  		ApplicationCaseMailer.digest(broker, @cases).deliver
  	end
    
  end

end