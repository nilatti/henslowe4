class Ability
  include CanCan::Ability

  def initialize(user)
    
     user ||= User.new # guest user (not logged in)
     if user.superadmin?
       can :manage, :all
     end

     if user
      can :manage, Theater do |theater|
        user.theater_admin?(theater)
      end
      can :manage, Production do |production|
        user.production_admin?(production)
      end
      can :read, Theater, jobs: { :user_id => user.id }
      can :read, Production, :theater => { :id => user.theater_ids }
      can :read, Play, :production => { :id => user.production_ids }
      can :read, [Act, Scene, FrenchScene, Character]        
      can :manage, User, :id => user.id
      can :manage, Job, :user_id => user.id

     else
      can :read, :all#Welcome
      #generic welcome page is all they can see
     end


   end
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
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

end
