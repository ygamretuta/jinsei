class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    alias_action [:all, :category], :to => :custom_product
    alias_action [:category], :to => :custom_business

    if user.role == 'admin'
      can :manage, :all
    else
      can :read, :all
      can :custom_product, Product
      can :custom_business, Business

      if user.role == 'user'
        can :manage, [Business, Product, Catalog, User]
      end
    end
  end
end
