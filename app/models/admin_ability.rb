class AdminAbility
  include CanCan::Ability

  def initialize(admin_user)
    admin_user ||= AdminUser.new
    can :manage, :all if admin_user.role == 'superuser'

    if admin_user.role == 'staff'
      can :read, :all
      can :manage, [Business, Review, Product]
      cannot :destroy, [Business, Product, Review]
    end
  end
end