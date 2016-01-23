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
    if user.has_role? :admin
      # an admin can do everything
      can :manage, :all



    elsif user.has_role? :ceo
      # an ceo can do everything to the following
      can :manage, [AccountsInvoice, AccountsInvoiceItem, Category, Country, Notification,
                    Opportunity, Organisation, Participant, Participation, Program, ProgramDate, ProgramVenue, Training, UserNotification,
                    Profile, ProfileBankDetail, ProfilePersonalDetail, ProfileContactDetail, ProfileGeneralDetail]
      # can [:read, :create, :update], Chart
      # an editor can only view the annual report
      # can :read, AnnualReport



    elsif user.has_role? :finance
      can :manage, [AccountsInvoice, AccountsInvoiceItem]
      can :read, :all


    elsif user.has_role? :program_coordinator
      can :manage, [Program, ProgramVenue, ProgramDate]
      can :read, :all

    elsif user.has_role? :manager
      can :manage, [Program, ProgramVenue, ProgramDate]
      can :read, :all

    elsif user.has_role? :marketing
      can :manage, [Program, ProgramVenue, ProgramDate]
      can :read, :all


    elsif user.has_role? :staff
      can :read, :all


    elsif user.has_role? :guest
      can :read, [Profile, ProfileContactDetail, ProfilePersonalDetail, ProfileBankDetail, ProfileGeneralDetail]
    end

  end
end