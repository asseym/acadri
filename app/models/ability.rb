class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities

    # Define abilities for the passed in user here.
    user ||= User.new # guest user (not logged in)
    # a signed-in user can do everything
    if user.has_role? :superadmin
      can :manage, :all


    elsif user.has_role? :ceo
      # an admin can do everything
      can :manage, :all


    elsif user.has_role? :admin
      # an ceo can do everything to the following
      can :manage, [AccountsInvoice, AccountsInvoiceItem, Category, Country, Notification,
                    Opportunity, Organisation, Participant, Participation, Program, ProgramDate, ProgramVenue, Training, UserNotification,
                    ProfileBankDetail, ProfilePersonalDetail, ProfileContactDetail, ProfileGeneralDetail, StaticPage, User]
      # can [:read, :create, :update], Chart
      # an editor can only view the annual report
      # can :read, AnnualReport



    elsif user.has_role? :finance
      can :manage, [AccountsInvoice, AccountsInvoiceItem, Opportunity, OpportunityStatus, Organisation, UserNotification, Notification]
      can :read, :all


    elsif user.has_role? :program_coordinator
      can :manage, [Program, ProgramVenue, ProgramDate, Opportunity, OpportunityStatus, Organisation, Participant, Participation, Training,
                 Notification, UserNotification]
      can :read, :all

    elsif user.has_role? :manager
      can :manage, [Program, ProgramVenue, ProgramDate, Opportunity, OpportunityStatus, Organisation, Participant, Participation,
                    ProfileBankDetail, ProfilePersonalDetail, ProfileContactDetail, ProfileGeneralDetail, Notification,
                 UserNotification]
      can :read, :all

    elsif user.has_role? :marketing
      can :manage, [Program, ProgramVenue, ProgramDate, Opportunity, OpportunityStatus, Organisation, Participant, Participation, Notification,
                 UserNotification]
      can :read, :all


    elsif user.has_role? :staff
      can :manage, [UserNotification, Notification]
      can :read, :all
      can [:read, :update], User, :user => user
      can :update, :user => user


    elsif user.has_role? :guest
      can :manage, [UserNotification, Notification]
      can [:read, :update], User, :user => user
      can :read, [StaticPage, ProfileContactDetail, ProfilePersonalDetail, ProfileBankDetail, ProfileGeneralDetail]
    end

  end
end
