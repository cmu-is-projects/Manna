class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # i.e., a guest user

    # set authorizations for different user roles
    if user.role? :admin
      # they get to do it all
      can :manage, :all

    elsif user.role?('care_deacon')
      #care deacon
      can :read, User

      can :read, Case do |c|
          c.deacon_id == user.id
      end
      can :edit, Case do |c|
        c.deacon_id == user.id
      end
      can :destroy, Case do |c|
        c.deacon_id == user.id
      end
      can :update, Case do |c|
        c.deacon_id == user.id
      end
      can :create, Case

    elsif user.role?('financial deacon')
      #financial deacon
      can :read, User
      can :create, Vote
      can :read, Case
      can :create, Case
      can :update, Case do |c|
        c.deacon_id == user.id
      end
      can :destroy, Case do |c|
        c.deacon_id == user.id
      end

    elsif user.role? :staff
      #care connector
      can :read, Vote
      can :read, Case
      can :update, Case #to edit status
      can :read, User
    
    elsif user.role?('head deacon')
      can :read, User
      can :create, Vote
      can :read, Case
      can :create, Case
      can :update, Case
      can :destroy, Case

    end
  end
end
