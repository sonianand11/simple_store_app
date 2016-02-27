class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)
    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :user
      can :read, :all
      can :create, :all
      can :update, Store, user_id: user.id
      can :update, Product, user_id: user.id

      can :destroy, Store, user_id: user.id
      can :destroy, Product, user_id: user.id
    else
      can :read, :all
    end    

  end
end
