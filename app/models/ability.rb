class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role == 'admin'
      can :manage, :all
    elsif user.role == 'user'
      can :manage, [Business, Product, Catalog, User]
    else
      can :read, :all
    end
  end
end
