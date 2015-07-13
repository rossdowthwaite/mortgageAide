class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    if user.is_broker? 
        can :manage, :all
        can :update, ApplicationCase do |app_case|
          app_case.is_brokered_by?(user) 
        end
        can :read, ApplicationCase do |app_case|
          app_case.is_brokered_by?(user) 
        end
        can :delete, ApplicationCase do |app_case|
          app_case.is_brokered_by?(user) 
        end
    else 
        # can do nothing
    end

    if user.is_client? 
        can :read, ApplicationCase do |app_case|
            app_case.applicants.include?(user)
        end
    end

    if user.is_client? 
        can :create, Note
        can :update, Note do |note|
            note.try(:user) == user;
        end
    end

  end
end
