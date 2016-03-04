class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)

    if user.has_role? :admin
      can :manage, :all

    elsif user.has_role? :user
      can :read, [Store,Product]
      can :create, :all
      can :update, Store, user_id: user.id
      can :update, Product, store_id: user.store_ids

      can :destroy, Store, user_id: user.id
      can :destroy, Product, store_id: user.store_ids

      cannot :index
      can [:show,:update,:destroy], User, id: user.id

    else
      can :read, [Store,Product]
      
    end    

  end
end
