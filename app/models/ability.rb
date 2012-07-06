class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role == 'admin'
      can :manage, :all
    elsif user.role == 'user'
      can :read, :all
    else
      can :read, :all
    end
  end
end
