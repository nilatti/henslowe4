class Ability
  include CanCan::Ability

  def initialize(user)
    
    user ||= User.new # guest user (not logged in)

    if user.superadmin?
      can :manage, :all

    elsif user.regular?
      can :manage, Theater do |theater|
        user.theater_admin?(theater)
      end

      can :manage, Production do |production|
        user.production_admin?(production) || user.theater_admin?(production.theater)
      end
      
      can :manage, Play do |play|
        if play.canonical? 
          false
        else
          puts play.production_id
          production = Production.find(play.production_id)
          user.production_admin?(production) || user.theater_admin?(production.theater)
        end
      end

      can :read, Play
      can :manage, Job do |job|
        user.theater_admin?(job.theater) || user.production_admin?(job.production)
      end

      can :read, Theater, jobs: { :user_id => user.id }
      can :read, Production, :id => user.production_ids
      
      can :read, [Act, Scene, FrenchScene, Character] 
      can :read, Author
      
      can [:show], User
      cannot :index, User
      can :manage, User, :id => user.id
      cannot :read, Job
      can :read, Job, :user_id => user.id
    else
      can :read, Welcome
    end
  end
end
