class User < ActiveRecord::Base
  has_many :businesses
  has_many :reviews, :dependent => :destroy

  before_validation :set_default_role

  validates :username, :presence=>true, :uniqueness => true
  validates_length_of :username, :in => 6..40
  validates :email, :presence => true, :uniqueness => true
  validate :valid_password
  validates_length_of :password, :in => 6..40, :allow_nil => true
  validates_confirmation_of :password

  devise :database_authenticatable,
         :registerable,
         :omniauthable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  attr_accessible :username,
                  :email,
                  :password,
                  :password_confirmation,
                  :remember_me,
                  :role,
                  :provider,
                  :uid

  ROLES = %w[admin user]

  def valid_password
    if self.provider.blank? and self.password.blank?
      errors.add(:password, :password_required)
    end
  end
  def active_for_authentication?
    super && !self.banned
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first

    unless user
      user = User.new(
        username: auth.info.name.gsub(/\s+/, '').downcase,
        provider: auth.provider,
        uid: auth.uid,
        password: Devise.friendly_token[0,20],
        email: auth.info.email,
        role: "user"
      )

      user.skip_confirmation!
      user.save!
    end

    user
  end

  def update_with_password(params={})
    if not params.has_key?(:password) or params[:password].blank?
      params.delete(:current_password)
      self.update_without_password(params)
    else
      self.verify_password_and_update(params)
    end
  end

  def update_without_password(params={})
    params.delete(:password)
    params.delete(:password_confirmation)
    result = update_attributes(params)
    clean_up_passwords
    result
  end

  def verify_password_and_update(params)
    current_password = params.delete(:current_password)

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation] .blank?
    end

    result = if valid_password?(current_password)
              update_attributes(params)
             else
              self.attributes = params
              self.valid?
              self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
            end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  private
    def set_default_role
      if self.role.blank?
        self.role = 'user'
      end
    end
end
