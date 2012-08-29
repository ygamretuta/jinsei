class AdminUser < ActiveRecord::Base
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  ROLES = %w[superuser staff]

  after_create {|admin| admin.send_reset_password_instructions}
  before_destroy :raise_if_last

  def password_required?
    new_record? ? false : super
  end

  def raise_if_last
    if AdminUser.count < 2
      raise "Can't delete last admin user"
    end
  end

  private
    def set_default_role
      if self.role.blank?
        self.role = 'staff'
      end
    end
end
